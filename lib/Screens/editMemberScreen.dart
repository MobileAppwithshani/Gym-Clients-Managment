import 'package:flutter/material.dart';
import 'package:local_db/Models/user_model.dart';
import 'package:local_db/db_hendler.dart';

class EditMemberScreen extends StatefulWidget {
  final UserModel member;
  final DBHelper dbHelper;

  EditMemberScreen({required this.member, required this.dbHelper});

  @override
  _EditMemberScreenState createState() => _EditMemberScreenState();
}

class _EditMemberScreenState extends State<EditMemberScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _genderController;
  late TextEditingController _joiningController;
  late TextEditingController _closingDateController;
  late TextEditingController _phoneController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _feeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.member.name);
    _genderController = TextEditingController(text: widget.member.gender);
    _joiningController = TextEditingController(text: widget.member.joining);
    _closingDateController = TextEditingController(text: widget.member.closing);
    _phoneController = TextEditingController(text: widget.member.phone.toString());
    _ageController = TextEditingController(text: widget.member.age.toString());
    _weightController = TextEditingController(text: widget.member.weight.toString());
    _heightController = TextEditingController(text: widget.member.height.toString());
    _feeController = TextEditingController(text: widget.member.fee.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _joiningController.dispose();
    _closingDateController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  void _updateMember() {
    if (_formKey.currentState!.validate()) {
      final updatedMember = UserModel(
        id: widget.member.id,
        name: _nameController.text,
        gender: _genderController.text,
        joining: _joiningController.text,
        closing: _closingDateController.text,
        phone: int.parse(_phoneController.text),
        age: int.parse(_ageController.text),
        weight: int.parse(_weightController.text),
        height: int.parse(_heightController.text),
        fee: int.parse(_feeController.text),
      );

      widget.dbHelper.update(updatedMember).then((value) {
        Navigator.pop(context, true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Members'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _joiningController,
                decoration: InputDecoration(labelText: 'Joining Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a joining date';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _closingDateController,
                decoration: InputDecoration(labelText: 'Closing Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a closing date';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a height';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _feeController,
                decoration: InputDecoration(labelText: 'Fee'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a fee';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateMember,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}