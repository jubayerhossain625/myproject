 import 'dart:io';
import 'dart:math';
class Logic{

   static String encryptCT(String key, String text) {
     List _key=[key];
     List _text =[text];

     int row = _key.length;
     int col = (_text.length/_key.length) as int;

     var twoDList = List.generate(row, (i) => List.filled(col, null, growable: false), growable: false);
     for(int i=0;i<key.length;i++){

     }


     print(twoDList);

   return key;
  }

}