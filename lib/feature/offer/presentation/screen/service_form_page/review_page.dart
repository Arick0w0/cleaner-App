// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';

// import '../../widgets/footer_app.dart';

// class ReviewPage extends StatelessWidget {
//   const ReviewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ຄວາມຄິດເຫັນ'),
//       ),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context)
//               .unfocus(); // Hide keyboard when tapping outside
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
//           child: Column(
//             children: [
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/mock/human.png',
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           ),
//                           const Gap(10),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('UserHunter01 ',
//                                     style:
//                                         Theme.of(context).textTheme.titleLarge),
//                                 Text('#Q3YZQVMIN',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleMedium),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Gap(25),
//                       Text('ຄວາມເພິງພໍໃຈຂອງການບໍລິການ',
//                           style: Theme.of(context).textTheme.titleLarge),
//                       const Gap(10),
//                       Row(
//                         children: const [
//                           Icon(
//                             Icons.star,
//                             color: Color(0xffFFBF06),
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Color(0xffFFBF06),
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Color(0xffFFBF06),
//                           ),
//                           Icon(
//                             Icons.star,
//                             color: Color(0xffFFBF06),
//                           ),
//                           Icon(
//                             Icons.star_half,
//                             color: Color(0xffFFBF06),
//                           ),
//                           // Icon(
//                           //   Icons.star_border_rounded,
//                           //   color: Color(0xffFFBF06),
//                           // ),
//                         ],
//                       ),
//                       const Gap(20),
//                       const MyCustomTextField(),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: FooterApp(
//           title: 'ຕົກລົງ',
//           onPressed: () => context.go('/home-job-offer', extra: {
//                 'initialTabIndex': 1,
//                 'initialActivityTabIndex': 1,
//               })),
//     );
//   }
// }

// class MyCustomTextField extends StatefulWidget {
//   const MyCustomTextField({super.key});

//   @override
//   _MyCustomTextFieldState createState() => _MyCustomTextFieldState();
// }

// class _MyCustomTextFieldState extends State<MyCustomTextField> {
//   final TextEditingController _controller = TextEditingController();
//   int _charCount = 0;
//   final int _maxLength = 255;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       decoration: BoxDecoration(
//         color: const Color(0xffE6E2E2),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Stack(
//         children: [
//           TextFormField(
//             controller: _controller,
//             keyboardType: TextInputType.multiline,
//             maxLines: null,
//             expands: true,
//             textAlignVertical: TextAlignVertical.top,
//             onChanged: (text) {
//               setState(() {
//                 _charCount = text.length;
//               });
//             },
//             style: const TextStyle(color: Colors.grey),
//             decoration: InputDecoration(
//               hintText: 'ຄວາມຄິດເຫັນ',
//               hintStyle: const TextStyle(color: Colors.grey),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               contentPadding: const EdgeInsets.all(10),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             right: 10,
//             child: Text(
//               '$_charCount/$_maxLength',
//               style: const TextStyle(color: Colors.grey),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
