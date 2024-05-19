// import 'package:flutter/material.dart';

// void showSnackBar(BuildContext context, String message) {
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   });
// }

// import 'package:flutter/material.dart';

// void showSnackBar(BuildContext context, String content) {
//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(
//       SnackBar(
//         content: Text(content),
//       ),
//     );
// }

import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content,
    {Color backgroundColor = Colors.black}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor,
      ),
    );
}
