import 'package:flutter/material.dart';

class DashboardComponent extends StatelessWidget {

  final String? imgURL;
  final String? title;
  final String? data;

  const DashboardComponent({super.key,
    required this.imgURL,
    required this.title,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.indigo,
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.4,
        height: MediaQuery.of(context).size.height*0.25,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.green[500],
                radius: 30,
                child: CircleAvatar(
                  backgroundImage: imgURL != null ? AssetImage(imgURL!) : null,
                  radius: 30,
                ), //CircleAvatar
              ), //CircleAvatar
              const SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                title!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ), //Textstyle
              ), //Text
              const SizedBox(
                  height: 10
              ), //SizedBox
              Text(
                data!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ), //Textstyle
              ), //Text
            ],
          ), //Column
        ), //Padding
      ), //SizedBox
    );
  }
}
