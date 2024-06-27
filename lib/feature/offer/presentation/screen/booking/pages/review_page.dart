import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../profile/address/widget/footer_app.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ຄວາມຄິດເຫັນ'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.amber),
                          ),
                          Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Somsy Sidouangty'),
                              Text('#SADASD5t4')
                            ],
                          )
                        ],
                      ),
                      Gap(25),
                      Text('ຄວາມເພິງພໍໃຈຂອງການບໍລິການ'),
                      Gap(10),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xffFFBF06),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFFBF06),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFFBF06),
                          ),
                          Icon(
                            Icons.star_half,
                            color: Color(0xffFFBF06),
                          ),
                          Icon(
                            Icons.star_border_rounded,
                            color: Color(0xffFFBF06),
                          ),
                        ],
                      ),
                      Gap(20),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(color: Color(0xffE6E2E2)),
                        child: Expanded(
                          child: TextFormField(
                            // decoration:
                            //     InputDecoration(labelText: 'Enter Message'),

                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            expands: true, // <-- SEE HERE
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: FooterApp(
            title: 'ຕົກລົງ',
            onPressed: () =>
                context.go('/home-job-offer', extra: {'initialTabIndex': 1})));
  }
}
