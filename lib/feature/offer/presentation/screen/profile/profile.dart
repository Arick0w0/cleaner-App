import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/utils/auth_utils.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';

import 'address/address_view.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<String?> _getToken() async {
    final localStorageService = LocalStorageService();
    final token = await localStorageService.getToken();
    print('Token retrieved: $token'); // Debug print
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Waiting for token'); // Debug print
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error retrieving token: ${snapshot.error}'); // Debug print
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final token = snapshot.data;
          // print('Token available: $token'); // Debug print

          return Scaffold(
            backgroundColor: MColors.white,
            appBar: AppBar(title: const Text('ໂປຣໄຟລ໌')),
            body: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  print('User loaded: ${state.user}'); // Debug print
                  final imageUrl = state.user.imageProfile;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text('${state.user.id}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.user.firstName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: MColors.black),
                                ),
                                const Gap(10),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'ແກ້ໄຂໂປໄຟລ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: MColors.accent),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: imageUrl.isNotEmpty
                                  ? Image.network(
                                      imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/mock/mock04.jpg',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        ),
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextAndIcon(
                            title: 'ການແຈ້ງເຕືອນ',
                            icon: Icon(
                              Icons.notifications_none_rounded,
                              size: 24,
                            ),
                          ),
                        ),
                        const Divider(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressView(
                                  userId: state.user.id,
                                  token: token ?? '',
                                ),
                              ),
                            );
                          },
                          child: const Padding(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('ອອກລະບົບ'),
                              GestureDetector(
                                onTap: () {
                                  print('Logout tapped'); // Debug print
                                  logout(context);
                                },
                                child: const Icon(
                                  Icons.logout_outlined,
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Text('Version 1.0.0'),
                      ],
                    ),
                  );
                }
                print('User state: ${state.runtimeType}'); // Debug print
                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        }
      },
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
