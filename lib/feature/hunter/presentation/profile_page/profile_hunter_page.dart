import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/secret/secret.dart';
import 'package:mae_ban/core/utils/auth_utils.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';

class HunterProfile extends StatelessWidget {
  const HunterProfile({super.key});

  Future<String?> _getToken() async {
    final localStorageService = LocalStorageService();
    return await localStorageService.getToken();
  }

  @override
  Widget build(BuildContext context) {
    const String baseUrl = Config.s3BaseUrl;

    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Scaffold(
            backgroundColor: MColors.white,
            appBar: AppBar(title: const Text('ໂປຣໄຟລ໌')),
            body: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  final user = state.user;
                  final imageUrl = user.imageProfile;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${user.firstName}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: MColors.black),
                                    ),
                                    const Gap(5),
                                    Text(
                                      'ແກ້ໄຂ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: MColors.accent),
                                    )
                                  ],
                                ),
                                const Gap(10),
                                Text('ID: ${user.customerCode}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: imageUrl.isNotEmpty
                                  ? Image.network(
                                      baseUrl + imageUrl,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                          'assets/mock/user.png',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/mock/user.png',
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
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextAndIcon(
                            title: 'ຂໍ້ມູນບັນຊີທະນາຄານ',
                            icon: Icon(
                              Icons.card_membership,
                              size: 24,
                            ),
                          ),
                        ),
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextAndIcon(
                            title: 'ກະເປົ໋າເງິນ',
                            icon: Icon(
                              Icons.wallet,
                              size: 24,
                            ),
                          ),
                        ),
                        const Divider(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextAndIcon(
                            title: 'ປະເພດບໍລິການ',
                            icon: Icon(
                              Icons.cleaning_services_outlined,
                              size: 24,
                            ),
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            // print('Logout tapped'); // Debug print
                            logout(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('ອອກລະບົບ'),
                                // GestureDetector(
                                Icon(
                                  Icons.logout_outlined,
                                  size: 24,
                                ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text('Version 1.0.0 (Demo)'),
                      ],
                    ),
                  );
                }
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
