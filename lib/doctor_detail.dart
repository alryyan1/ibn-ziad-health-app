import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorDetails extends StatelessWidget {
  DoctorDetails(
      {super.key,
      required this.name,
      required this.specialist_name,
      required this.ismale});
  String name;
  String specialist_name;
  bool ismale;
  @override
  Widget build(BuildContext context) {
    var image_name = this.ismale ? 'male' : 'female';
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SvgPicture.asset(
                'assets/svgs/${image_name}doctor.svg',
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Color.fromARGB(255, 82, 127, 83),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Tajawal-Regular',
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                specialist_name,
                style: TextStyle(
                    fontFamily: 'Tajawal-Regular',
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'السبت',
                style: TextStyle(color: Colors.grey, fontSize: 26),
              ),
              Text(
                'الاحد',
                style: TextStyle(color: Colors.grey, fontSize: 26),
              ),
              Text(
                'الاثنين',
                style: TextStyle(color: Colors.grey, fontSize: 26),
              ),
              Text(
                'الثلاثاء',
                style: TextStyle(color: Colors.grey, fontSize: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
