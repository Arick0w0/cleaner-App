import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/text_strings.dart';

class DialogSuccess extends StatelessWidget {
  const DialogSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AlertDialog(
        backgroundColor: Color(0xFFFFFFFF),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              SizedBox(
                  width: 100,
                  child: Image.asset(
                    MTexts.success,
                    fit: BoxFit.cover,
                  )),
              Gap(20),
              Text(
                'ຂອບໃຈທີໃຊ້ບໍລິການຂອງພວກເຮົາ',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        // content: const Text('ຂອບໃຈທີໃຊ້ບໍລິການຂອງພວກເຮົາ'),
        // actions: <Widget>[
        //   TextButton(
        //     child: const Text('OK'),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
      ),
    );
  }
}
