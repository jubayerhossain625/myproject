import 'package:caesar_cipler/transition.dart';
import 'package:flutter/material.dart';
import 'caesar_ciper.dart';
import 'custom_contanier.dart';
import 'onetimepad.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Caesar Cipher',
      home: _body(),
    );
  }
}

class _body extends StatefulWidget {
  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<_body> {

  @override
  Widget build(BuildContext context) {
    var w= MediaQuery.of(context).size.width;
    var h= MediaQuery.of(context).size.height;
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: h,
          width: w,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children:   <Widget>[
              const SizedBox(height: 50,),
              Image.network(imgs,height: 150,width: 150,),
              const SizedBox(height: 70,),

              InkWell(child: const Box(title: 'Caesar Ciper',),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CaesarCiper()));

              },
              ),
              const SizedBox(height: 40,),
              InkWell(child: const Box(title: 'OneTimePad',),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => OneTimePad()));
              },
              ),
              const SizedBox(height: 40,),
              InkWell(child: const Box(title: 'Transposition',),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Transition()));
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
  var imgs = 'https://cdn-icons-png.flaticon.com/512/1792/1792193.png';
}