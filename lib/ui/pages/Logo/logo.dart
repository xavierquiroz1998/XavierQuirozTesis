import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "itmas.png",
            width: double.infinity,
            height: 100,
          ),
          SizedBox(
            width: 10,
          ),
          // Text(
          //   "Logo",
          //   style: TextStyle(
          //       fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white),
          // ),
        ],
      ),
    );
  }
}
