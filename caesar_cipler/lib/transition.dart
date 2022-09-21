
import 'package:flutter/material.dart';

class Transition extends StatelessWidget {
  const Transition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Transposition Cipher"),
      ),
      body: const Center(child: CircularProgressIndicator(color: Colors.amber,)),

    );
  }
}
