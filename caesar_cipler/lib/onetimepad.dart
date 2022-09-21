
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class OneTimePad extends StatefulWidget {
  @override
  _OneTimePadState createState() => _OneTimePadState();
}

class _OneTimePadState extends State<OneTimePad> {
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  String _result = "";
  late String _key;


  @override
  void dispose() {
    _wordController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OneTimePad'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Input your text here',
                ),
                controller: _wordController,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                ],
                textCapitalization: TextCapitalization.sentences,
              ),
              Container(
                height: 32.0,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Input your key'),
                controller: _keyController,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                ],
                textCapitalization: TextCapitalization.sentences,
              ),
              Container(
                height: 32.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      this._process(true);
                    },
                    color: Colors.green,
                    child:const Text("Encrypt"),
                  ),
                  MaterialButton(
                    color: Colors.brown,
                    onPressed: () {
                      this._process(false);
                    },
                    child: const Text("Decrypt"),
                  ),
                  MaterialButton(
                    onPressed: _delete,
                    color: Colors.red,
                    child: const Text("CLEAR"),
                  ),
                ],
              ),
              Container(
                height: 64.0,
              ),
              const Text(
                'Output :',
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 32.0,
              ),
              SelectableText(
                _result,
                style: const TextStyle(fontSize: 32.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _process(bool _isEncrypt) {
    // get User Text
    String _text = _wordController.text.toUpperCase();

    String _temp = "";
    try {

      // get User of Key
      _key = _keyController.text.toUpperCase();

    } catch (e) {
      _showAlert("Invalid Key");
    }


    for (int i = 0; i < _text.length; i++) {
      int ch = _text.codeUnitAt(i);
      int key = _key.codeUnitAt(i);
      int offset;
      String h;

      // fixed of A to Z index 1 to 26
      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) {
        offset = 97;
      } else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (ch == ' '.codeUnitAt(0)) {
        _temp += " ";
        continue;
      } else {
        _showAlert("Invalid Text");
        _temp = "";
        break;
      }
      //cheek length of text and key
      if(_text.length == _key.length) {
        int c;
        int c1;
        int d1;

        // encrypting data
        if (_isEncrypt) {
               int x = ch-offset+1;
               int y = key-offset+1;
                c1 = x+y;
                    if(c1 > 26){
                      c = (x + y ) % 26;
                      c=c-1;
                    }else{
                     c=x+y;
                     c=c-1;
                     }
        } else { // decrypting data
                 int x = ch-offset+1;
                 int y = key-offset+1;
                 d1 = x-y ;

               if(d1<0){
                   c = (x - y ) % 26;
                   c=c-1;
                }else{
                     c=d1-1;
                  }
        }
         // get current Result
        h = String.fromCharCode(c + offset);
        _temp += h;
      }else{
        _showAlert("isnNot Same Length");
      }
    }

    setState(() {
      _result = _temp;
    });
  }

  void _delete() {
    _wordController.clear();
    _keyController.clear();
    setState(() {
      _result = "";
    });
  }

  Future<void> _showAlert(String _alert) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Something is Wrong'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_alert),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}