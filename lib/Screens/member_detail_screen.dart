import 'package:flutter/material.dart';
import 'package:local_db/Components/details_component.dart';
import 'package:local_db/Models/user_model.dart';

class MemberDetailScreen extends StatelessWidget {
  final UserModel member;

  MemberDetailScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100]!.withOpacity(0.3),
        centerTitle: true,
        title: Text('${member.name} Details', ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/backgroud.jpg'
            ),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.85,
            height: MediaQuery.of(context).size.height*0.45,
            decoration: BoxDecoration(
              color: Colors.brown[200]!.withOpacity(0.94),
              borderRadius: BorderRadius.circular(10.0)
            ),

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                      member.name,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.indigo
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),

                 DetailsComponent(
                     icon: Icons.male,
                     label: "Gender",
                     value: member.gender
                 ),
                  SizedBox(
                    height: 3,
                  ),
                  DetailsComponent(icon: Icons.emergency,
                      label: 'Age',
                      value: '${member.age}'
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  DetailsComponent(
                      icon: Icons.monitor_weight,
                      label: 'Weight',
                      value: '${member.weight}'
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  DetailsComponent(
                      icon: Icons.height,
                      label: 'Height',
                      value: '${member.height}'
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  DetailsComponent(
                      icon: Icons.phone_android_sharp,
                      label: 'Contact',
                      value: '${member.phone}',
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  DetailsComponent(
                      icon: Icons.calendar_month,
                      label: "Joining",
                      value: member.joining
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  DetailsComponent(
                      icon: Icons.timer_rounded,
                      label: 'Ending',
                      value: member.closing
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
