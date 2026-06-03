import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_radii.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/core/theme/auth_material_theme.dart';
import 'package:vroom/core/theme/bloc/theme_bloc.dart';
import 'package:vroom/features/auth/view/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final authTheme = theme.extension<AuthMaterialTheme>()!;
    final l10n = AppLocalizations.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (user) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.welcomeUser(user.login))),
            );
            context.go(
              user.isStaff
                  ? AppRoutes.organizerEvents.path
                  : AppRoutes.home.path,
            );
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
                          alignment: Alignment.centerRight,
                          child: Material(
                            color: authTheme.iconBackground,
                            shape: const CircleBorder(),
                            child: IconButton(
                              onPressed: () {
                                context.read<ThemeBloc>().add(
                                  const ThemeEvent.toggled(),
                                );
                              },
                              icon: Icon(
                                isDark
                                    ? Icons.light_mode_outlined
                                    : Icons.dark_mode_outlined,
                                color: authTheme.iconColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 56),
                        Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return AppColors.primaryGradient.createShader(
                                bounds,
                              );
                            },
                            child: const Text(
                              'A',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 56,
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing8),
                        Center(
                          child: Text(
                            'ARient',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: authTheme.accent,
                              fontSize: 42 / 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing8),
                        Center(
                          child: Text(
                            l10n.loginSubtitle,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing40),
                        TextField(
                          controller: _loginController,
                          enabled: !isLoading,
                          decoration: _inputDecoration(
                            hint: l10n.loginFieldLogin,
                            authTheme: authTheme,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing16),
                        TextField(
                          controller: _passwordController,
                          enabled: !isLoading,
                          obscureText: _obscurePassword,
                          decoration: _inputDecoration(
                            hint: l10n.loginFieldPassword,
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
                        const SizedBox(height: AppSizes.spacing16),
                        AppGradientButton(
                          label: l10n.loginButton,
                          isLoading: isLoading,
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                    AuthEvent.login(
                                      login: _loginController.text.trim(),
                                      password: _passwordController.text,
                                    ),
                                  );
                                },
                        ),
                        const SizedBox(height: AppSizes.spacing16),
                        SizedBox(
                          height: AppSizes.buttonHeight,
                          child: OutlinedButton.icon(
                            onPressed: isLoading ? null : () {},
                            icon: const Icon(Icons.qr_code_2_rounded),
                            label: Text(l10n.loginQrButton),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: authTheme.primaryText,
                              backgroundColor: authTheme.inputFill,
                              side: BorderSide(color: authTheme.border),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadii.md,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.loginNoAccount,
                              style: theme.textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      context.push(AppRoutes.register.path);
                                    },
                              style: TextButton.styleFrom(
                                foregroundColor: authTheme.accent,
                              ),
                              child: Text(l10n.loginRegisterLink),
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
    super.dispose();
  }
}
