import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
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
          if (state is AuthSuccess && state.status == 'PASSWORD_RESET') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Password reset successful'),
            ));
            Navigator.pop(context);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
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
                Gap(50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final newPassword = _passwordController.text;
                      context.read<AuthBloc>().add(ResetPasswordEvent(
                          userId: userId,
                          newPassword: newPassword,
                          token: token));
                    },
                    child: Text(MTexts.newPassword),
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
