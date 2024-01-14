import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:test_clean_arch/features/auth/presentation/pages/login_screen.dart';
import 'package:test_clean_arch/features/splash/presentation/manager/splash_cubit.dart';

import '../../../../core/utils/general_helper.dart';
import '../../../../injection_container.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final _bloc = sl<SplashCubit>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: GeneralHelper
          .of(context)
          .onWillPop,
      child: BlocProvider(
        create: (context) => _bloc..goToHome(),
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashDataLoaded) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }
          },
          child: Scaffold(
            body: Container(
              padding: EdgeInsets.only(bottom: 8.h),
              width: 100.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: FlutterLogo(
                      size: 50.w,
                      duration: const Duration(seconds: 3),
                    ).animate()
                        .slideY(duration: 900.ms, curve: Curves.easeOutCubic)
                        .fadeIn(delay: 200.ms),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
