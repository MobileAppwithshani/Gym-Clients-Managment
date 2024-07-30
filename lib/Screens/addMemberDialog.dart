import 'package:flutter/material.dart';
import 'package:local_db/Models/user_model.dart';
import 'package:local_db/db_hendler.dart';

class AddMemberDialog extends StatefulWidget {
  final DBHelper dbHelper;
  final VoidCallback onMemberAdded;

  const AddMemberDialog({required this.dbHelper, required this.onMemberAdded});

  @override
  _AddMemberDialogState createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _feeController = TextEditingController();
  final _joiningDateController = TextEditingController();
  final _closingDateController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _selectedGender;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _feeController.dispose();
    _joiningDateController.dispose();
    _closingDateController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Member', style: TextStyle(color: Colors.indigo)),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Prefer not to say']
                    .map((label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _feeController,
                decoration: InputDecoration(labelText: 'Fee (PKR)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a fee';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _joiningDateController,
                decoration: InputDecoration(labelText: 'Joining Date'),
                readOnly: true,
                onTap: () => _selectDate(context, _joiningDateController),
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
                readOnly: true,
                onTap: () => _selectDate(context, _closingDateController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a closing date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age (years)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height (cms)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a height';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight (Kgs)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a weight';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.dbHelper.insert(UserModel(
                name: _nameController.text,
                gender: _selectedGender!,
                joining: _joiningDateController.text,
                closing: _closingDateController.text,
                phone: int.parse(_phoneController.text),
                age: int.parse(_ageController.text),
                weight: int.parse(_weightController.text),
                height: int.parse(_heightController.text),
                fee: int.parse(_feeController.text),
              )).then((value) {
                print("Data Added...!");
                widget.onMemberAdded();
                Navigator.of(context).pop();
              }).onError((error, stackTrace) {
                print(error.toString());
              });
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
