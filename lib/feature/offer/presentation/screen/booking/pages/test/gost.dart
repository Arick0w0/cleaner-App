import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ຂໍ້ຄວາມລະບົບ'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo/gost.gif',
          ),
          const Text('ບໍມີການແຈ້ງເຕືອນ')
        ],
      )),
    );
  }
}
