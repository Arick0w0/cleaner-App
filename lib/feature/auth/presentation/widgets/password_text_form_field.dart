import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/feature/auth/presentation/bloc/obscure_text_bloc.dart';

class PasswordTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool showSuffixIcon;
  final String error;
  final Icon icon;

  const PasswordTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.error,
    required this.icon,
    this.validator,
    this.showSuffixIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ObscureTextCubit(),
      child: BlocBuilder<ObscureTextCubit, bool>(
        builder: (context, isObscure) {
          return TextFormField(
            controller: controller,
            obscureText: isObscure,
            decoration: InputDecoration(
              prefixIcon: icon,
              labelText: labelText,
              suffixIcon: showSuffixIcon
                  ? IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () =>
                          context.read<ObscureTextCubit>().toggleObscureText(),
                    )
                  : null,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return error;
              }
              return validator?.call(value);
            },
          );
        },
      ),
    );
  }
}
