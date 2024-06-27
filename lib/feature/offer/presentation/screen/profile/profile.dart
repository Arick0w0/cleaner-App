import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/utils/auth_utils.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';

import 'address/address_view.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.white,
      appBar: AppBar(title: const Text('ໂປຣໄຟລ໌')),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text('User ID : ${state.user.id}'),
                  // Text('User ID : ${state.user.firstName}'),
                  // Text('User ID : ${state.user.lastName}'),
                  // Text('User ID : ${state.user.phone}'),
                  // Text('User ID : ${state.user.role}'),
                  // Text('User ID : ${state.user.token}'),
                  // Text('User ID : ${state.user.token}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${state.user.firstName}'),
                          Gap(10),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'ແກ້ໄຂໂປໄຟຮ',
                            ),
                          )
                        ],
                      ),
                      Gap(180),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      const Gap(10),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextAndIcon(
                      title: 'ການແຈ້ງເຕືອນ',
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      // MaterialPageRoute(
                      //   builder: (context) => AddressView(
                      //     userId: widget.userId,
                      //     token: widget.token,
                      //   ),
                      // );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextAndIcon(
                        title: 'ທີພັກຂອງຂ້ອຍ',
                        icon: Icon(
                          Icons.home_outlined,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextAndIcon(
                      title: 'ຕິດຕໍ່ສູນບໍລິການ',
                      icon: Icon(
                        Icons.message,
                        size: 24,
                      ),
                    ),
                  ),
                  const Divider(),
                  // TextAndIcon(
                  //   title: 'ຕິດຕໍ່ສູນບໍລິການ',
                  //   icon: Icon(
                  //     Icons.logout_outlined,
                  //     size: 24,
                  //   ),
                  // ),
                  // const Divider(),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ອອກລະບົບ'),
                        GestureDetector(
                          onTap: () => logout(context),
                          child: Icon(
                            Icons.logout_outlined,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(100),
                  const Text('Versions 1.0.0'),
                  // TextAndIcon(
                  //   title: 'ອອກລະບົບ',
                  //   icon: IconButton(
                  //     onPressed: () => ,
                  //     Icons.notifications_none_rounded,
                  //     size: 24, icon: Icon(icon),
                  //   ),
                  // ),
                  // const Divider(),

                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: ElevatedButton(
                  //     child: const Text('Logout'),
                  //     onPressed: () => logout(context),
                  //   ),
                  // ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class TextAndIcon extends StatelessWidget {
  final String title;
  final Icon icon;
  const TextAndIcon({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        icon,
      ],
    );
  }
}
