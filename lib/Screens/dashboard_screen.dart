import 'package:flutter/material.dart';
import 'package:local_db/Components/dashboard_component.dart';
import 'package:local_db/Models/user_model.dart';
import 'package:local_db/db_hendler.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DBHelper? dbHelper;
  late Future<List<UserModel>> membersList;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    membersList = dbHelper!.getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: membersList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()
            );
          }
          else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')
            );
          }
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
                    'No data available'
                )
            );
          }
          else {
            int totalPersons = snapshot.data!.length;
            int totalFee = snapshot.data!.fold(0, (sum, member) => sum + member.fee);

            return Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      DashboardComponent(
                          imgURL: "assets/app.png",
                          title: "Active Members",
                          data: '$totalPersons'
                      ),
                      DashboardComponent(
                          imgURL: "assets/app.png",
                          title: "Fee Collection",
                          data: '$totalFee'
                      ),




                    ],
                  ),

                ],
              ),
            );
          }
        },
      ),
    );
  }
}
