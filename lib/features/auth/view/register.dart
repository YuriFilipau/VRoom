import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

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
        appBar: AppBar(title: const Text('Регистрация')),
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
                        Text('Создать аккаунт', style: textTheme.headlineSmall),
                        const SizedBox(height: AppSizes.spacing12),
                        Text(
                          'Зарегистрируйтесь, чтобы сохранить прогресс и достижения.',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSizes.spacing32),
                        TextField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(labelText: 'Имя'),
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: AppSizes.spacing16),
                        TextField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Фамилия',
                          ),
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: AppSizes.spacing16),
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
                          label: 'Зарегистрироваться',
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                    AuthEvent.register(
                                      login: _loginController.text,
                                      password: _passwordController.text,
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                    ),
                                  );
                                },
                        ),
                        const SizedBox(height: AppSizes.spacing12),
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.pop();
                                },
                          child: const Text('Уже есть аккаунт? Войти'),
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
