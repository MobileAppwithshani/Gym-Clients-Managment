import 'package:flutter/material.dart';
import 'package:local_db/Models/user_model.dart';
import 'package:local_db/Screens/addMemberDialog.dart';
import 'package:local_db/Screens/editMemberScreen.dart';
import 'package:local_db/Screens/member_detail_screen.dart';
import 'package:local_db/db_hendler.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final DBHelper _dbHelper = DBHelper();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late Future<List<UserModel>> _membersFuture;

  @override
  void initState() {
    super.initState();
    _membersFuture = _dbHelper.getMembers();
  }

  void _refreshMembers() {
    setState(() {
      _membersFuture = _dbHelper.getMembers();
    });
  }

  void _addMember() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AddMemberDialog(
        dbHelper: _dbHelper,
        onMemberAdded: _refreshMembers,
      ),
    );
    if (result == true) {
      _refreshMembers();
    }
  }

  void _editMember(UserModel member) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMemberScreen(member: member, dbHelper: _dbHelper),
      ),
    );
    if (result == true) {
      _refreshMembers();
    }
  }

  void _deleteMember(int id) {
    _dbHelper.delete(id).then((_) {
      _refreshMembers();
    });
  }

  void _viewMemberDetails(UserModel member) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberDetailScreen(member: member),
      ),
    );
  }

  List<UserModel> _filterMembers(List<UserModel> members) {
    if (_searchQuery.isEmpty) {
      return members;
    }
    return members.where((member) {
      return member.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          member.phone.toString().contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addMember,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _membersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No members found.'));
          } else {
            final members = _filterMembers(snapshot.data!);
            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return Card(
                  color: Colors.purple[500]!.withOpacity(0.8),
                  child: ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.person, size: 20, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          member.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.phone, size: 20, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          '${member.phone}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: () => _editMember(member),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () => _deleteMember(member.id!),
                        ),
                      ],
                    ),
                    onTap: () => _viewMemberDetails(member),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}