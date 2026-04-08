import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (user) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Добро пожаловать, ${user.login}!')),
            );
            context.go(AppRoutes.home.path);
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.error,
              ),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Вход')),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );
            final textTheme = Theme.of(context).textTheme;

            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(
                    AppSizes.screenHorizontalPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('VRoom', style: textTheme.headlineSmall),
                        const SizedBox(height: AppSizes.spacing12),
                        Text(
                          'Войдите, чтобы продолжить обучение и проходить AR-квесты.',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSizes.spacing32),
                        TextField(
                          controller: _loginController,
                          decoration: const InputDecoration(labelText: 'Логин'),
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: AppSizes.spacing16),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Пароль',
                          ),
                          obscureText: true,
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: AppSizes.spacing24),
                        AppGradientButton(
                          label: 'Войти',
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                    AuthEvent.login(
                                      login: _loginController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                },
                        ),
                        const SizedBox(height: AppSizes.spacing12),
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.push(AppRoutes.register.path);
                                },
                          child: const Text('Нет аккаунта? Зарегистрироваться'),
                        ),
                        const SizedBox(height: AppSizes.spacing24),
                        const Divider(color: AppColors.border),
                        const SizedBox(height: AppSizes.spacing16),
                        Text(
                          'После первого запуска онбординг больше не показывается.',
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
