
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  const Box({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    var w= MediaQuery.of(context).size.width;
    return  Container(
      height:80,
      alignment: Alignment.center,
      width: w*0.8,
      decoration: BoxDecoration(
        color: Color(0xFF94CCF9),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF04589A),
            offset: Offset(7, 7),
            blurRadius: 10,
          ),
        ],
      ),
      child:  Text(title, style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700, color: Color(0xFF04589A),),),
    );
  }
}
