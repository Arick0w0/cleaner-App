import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/core/utils/auth_utils.dart';
import 'package:mae_ban/feature/auth/presentation/cubit/user_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hunter Profile')),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User ID : ${state.user.id}'),
                Text('User ID : ${state.user.firstName}'),
                Text('User ID : ${state.user.lastName}'),
                Text('User ID : ${state.user.phone}'),
                Text('User ID : ${state.user.role}'),
                Text('User ID : ${state.user.token}'),
                // Text('User ID : ${state.user.token}'),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Logout'),
                    onPressed: () => logout(context),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
