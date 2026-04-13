import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/core/theme/auth_material_theme.dart';
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
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authTheme = theme.extension<AuthMaterialTheme>()!;

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
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: isLoading ? null : () => context.pop(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 24,
                              minHeight: 24,
                            ),
                            visualDensity: VisualDensity.compact,
                            icon: Icon(Icons.arrow_back, color: authTheme.iconColor),
                          ),
                        ),
                        const SizedBox(height: 56),
                        Text(
                          'Регистрация',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 40 / 1.5,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing4),
                        Text(
                          'Создай аккаунт и начни путешествие',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSizes.spacing32),
                        TextField(
                          controller: _firstNameController,
                          enabled: !isLoading,
                          decoration: _inputDecoration(
                            hint: 'Имя',
                            authTheme: authTheme,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing16),
                        TextField(
                          controller: _lastNameController,
                          enabled: !isLoading,
                          decoration: _inputDecoration(
                            hint: 'Фамилия',
                            authTheme: authTheme,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing16),
                        TextField(
                          controller: _loginController,
                          enabled: !isLoading,
                          decoration: _inputDecoration(
                            hint: 'Логин',
                            authTheme: authTheme,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing16),
                        TextField(
                          controller: _passwordController,
                          enabled: !isLoading,
                          obscureText: _obscurePassword,
                          decoration: _inputDecoration(
                            hint: 'Пароль',
                            authTheme: authTheme,
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: authTheme.iconColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing20),
                        AppGradientButton(
                          label: 'Зарегистрироваться',
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                    AuthEvent.register(
                                      login: _loginController.text.trim(),
                                      password: _passwordController.text,
                                      firstName: _firstNameController.text
                                          .trim(),
                                      lastName: _lastNameController.text.trim(),
                                    ),
                                  );
                                },
                        ),
                        const SizedBox(height: AppSizes.spacing20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Уже есть аккаунт?',
                              style: theme.textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      context.pop();
                                    },
                              style: TextButton.styleFrom(
                                foregroundColor: authTheme.accent,
                              ),
                              child: const Text('Войти'),
                            ),
                          ],
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

  InputDecoration _inputDecoration({
    required String hint,
    required AuthMaterialTheme authTheme,
    Widget? suffix,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadii.md),
      borderSide: BorderSide(color: authTheme.border),
    );

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: authTheme.hintText),
      filled: true,
      fillColor: authTheme.inputFill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      suffixIcon: suffix,
      enabledBorder: border,
      border: border,
      focusedBorder: border.copyWith(
        borderSide: BorderSide(color: authTheme.accent, width: 1.3),
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
