import 'package:couptick/configs/assets/app_images.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/splash_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (_, state) {
          switch (state) {
            case SplashInitial():
            case NavigateToHomeActionState():
              context.goNamed(Routes.home);

            case NavigateToLoginActionState():
              context.goNamed(Routes.login);
          }
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Image.asset(AppImages.textLogo, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
