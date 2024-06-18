import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/core/utils/show_snackbar.dart';
import 'package:mae_ban/core/widgets/loader.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/password_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String userId;
  final String token;
  final TextEditingController _passwordController = TextEditingController();

  ResetPasswordScreen({super.key, required this.userId, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MTexts.resetPassword)),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            showSnackBar(
                backgroundColor: MColors.emerald, context, MTexts.resetSuccess);
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PasswordTextFormField(
                  controller: _passwordController,
                  labelText: MTexts.password,
                  error: MTexts.plsenterpassword,
                  icon: const Icon(Icons.password),
                ),
                const Gap(50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final newPassword = _passwordController.text;
                      context.read<AuthBloc>().add(ResetPasswordWithTokenEvent(
                          userId: userId,
                          token: token,
                          newPassword: newPassword));
                    },
                    child: const Text(MTexts.newPassword),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
