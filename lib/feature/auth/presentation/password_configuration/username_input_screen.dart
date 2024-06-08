import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/password_configuration/reset_password_screen.dart';
import 'package:mae_ban/feature/auth/presentation/widgets/text_form_field.dart';

class UsernameInputScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  UsernameInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MTexts.forgotPassword),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is TokenReceived) {
            final userId = context
                .read<AuthBloc>()
                .resetPasswordUseCase
                .decodeTokenToGetUserId(state.token);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ResetPasswordScreen(userId: userId, token: state.token),
              ),
            );
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

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(MTexts.person),
                  ),
                  CustomTextFormField(
                    controller: _usernameController,
                    labelText: MTexts.phoneNumber,
                    prefixIcon: const Icon(Icons.phone),
                    usePrefix: true, // Set the prefix to 020
                    keyboardType: TextInputType.phone,
                    useMaxLength: true, // Enable max length
                    errorText: MTexts.pleaseenteryourphonenumber,
                  ),
                  const Gap(50),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // final username = _usernameController.text;
                        // context.read<AuthBloc>().add(GetTokenEvent(username));
                        context.push('/Otp-screen');
                      },
                      child: const Text(MTexts.verify),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
