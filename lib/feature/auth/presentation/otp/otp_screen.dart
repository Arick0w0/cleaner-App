import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/constants/size.dart';
import 'package:mae_ban/core/constants/text_strings.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'reset_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String bearerToken;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.bearerToken,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpFieldController otpController = OtpFieldController();
  String _otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordOtpVerified) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(
                  userId: state.userId,
                  token: state.token,
                ),
              ),
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed: ${state.error}')),
            );
          } else if (state is ResetPasswordOtpSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(' ສົ່ງOTP'),
                backgroundColor: Colors.greenAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 150),
              child: Column(
                children: [
                  Text(
                    MTexts.confirmOtp,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Gap(40),
                  OTPTextField(
                    controller: otpController,
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 15,
                    style: const TextStyle(fontSize: 17),
                    onChanged: (pin) {
                      setState(() {
                        _otp = pin;
                      });
                      print("Changed: " + pin);
                    },
                    onCompleted: (pin) {
                      setState(() {
                        _otp = pin;
                      });
                      print("Completed: " + pin);
                      context
                          .read<AuthBloc>()
                          .add(VerifyOtpEvent(widget.phoneNumber, _otp));
                    },
                  ),
                  const Gap(MSize.defaultSize),
                  TextButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(SendOtpAgainEvent(widget.phoneNumber));
                    },
                    child: Text(
                      MTexts.sendAgain,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: MColors.accent,
                          decoration: TextDecoration.underline,
                          decorationColor: MColors.lights),
                    ),
                  ),
                  const Gap(MSize.spaceBtwSections),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_otp.isNotEmpty) {
                          context
                              .read<AuthBloc>()
                              .add(VerifyOtpEvent(widget.phoneNumber, _otp));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter the OTP')),
                          );
                        }
                      },
                      child: const Text('ຍືນຍັ້ນ'),
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
