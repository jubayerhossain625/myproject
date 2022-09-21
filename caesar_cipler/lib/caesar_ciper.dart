import 'package:flutter/material.dart';


class CaesarCiper extends StatefulWidget {
  @override
  _CaesarCiperState createState() => _CaesarCiperState();
}

class _CaesarCiperState extends State<CaesarCiper> {
  TextEditingController _wordController = TextEditingController();
  TextEditingController _keyController = TextEditingController();
  String _result = "";
  late int _key;


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
        title: Text('Caesar Ciper'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Input your text here',
                  ),
                  controller: _wordController,
                  keyboardType: TextInputType.text,
                ),
                Container(
                  height: 32.0,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Input your key'),
                  controller: _keyController,
                  keyboardType: TextInputType.number,
                ),
                Container(
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    MaterialButton(
                      child: Text("Encrypt"),
                      onPressed: () {
                        this._process(true);
                      },
                      color: Colors.green,
                    ),
                    MaterialButton(
                      child: Text("Decrypt"),
                      color: Colors.grey,
                      onPressed: () {
                        this._process(false);
                      },
                    ),
                    MaterialButton(
                      onPressed: _delete,
                      color: Colors.red,
                      child: const Text("Clear"),
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
        ],
      ),
    );
  }

  void _process(bool _isEncrypt) {
    // get user text for encrypt or decrypt
    String _text = _wordController.text;
    String _temp = "";
    try {
      // get user key for encrypt or decrypt only number
      _key = int.parse(_keyController.text);
    } catch (e) {
      _showAlert("Invalid Key");
    }


    for (int i = 0; i < _text.length; i++) {
      int ch = _text.codeUnitAt(i);
      int offset;
      String h;

      // fixing to A-Z index of (0-26)
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

      int c;
      if (_isEncrypt) {
        // encrypting of data
        c = (ch + _key - offset) % 26;
      } else {
        // decrypting of data
        c = (ch - _key - offset) % 26;
      }
      h = String.fromCharCode(c + offset);
      _temp += h;
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
          title: Text('Something is Wrong'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_alert),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Ok'),
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