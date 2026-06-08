import 'package:couptick/common/utils/app_screen_util.dart';
import 'package:couptick/configs/theme/app_colors.dart';
import 'package:couptick/configs/theme/app_theme.dart';
import 'package:couptick/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColors.white,
      systemNavigationBarDividerColor: AppColors.white,
      systemNavigationBarColor: AppColors.white,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ScreenUtilInit(
        designSize: Size(constraints.maxWidth, constraints.maxHeight),
        minTextAdapt: true,
        ensureScreenSize: true,
        splitScreenMode: true,
        builder: (context, child) {
          final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
          AppScreenUtil().init(constraints);
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(isTablet ? 1.2 : 1.0)),
            child: MaterialApp.router(
              title: 'CoupTick',
              debugShowCheckedModeBanner: false,
              routerConfig: Pages.appRouter,
              theme: AppThemes.lightTheme,
            ),
          );
        },
      ),
    );
  }
}
