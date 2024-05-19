import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mae_ban/feature/auth/persentation/bloc/auth_bloc.dart';

void logout(BuildContext context) {
  context.read<AuthBloc>().add(LogoutEvent());
  context.go('/login'); // Use go_router for navigation
}
