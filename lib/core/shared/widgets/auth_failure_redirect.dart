import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';

class AuthFailureRedirect extends StatefulWidget {
  const AuthFailureRedirect({
    super.key,
    required this.message,
    this.delay = const Duration(seconds: 2),
  });

  final String message;
  final Duration delay;

  @override
  State<AuthFailureRedirect> createState() => _AuthFailureRedirectState();
}

class _AuthFailureRedirectState extends State<AuthFailureRedirect> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (!mounted) {
        return;
      }
      context.read<AuthBloc>().add(const AuthEvent.logout());
      context.go(AppRoutes.login.path);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          '${widget.message}\n\nВозвращаем на экран входа...',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
