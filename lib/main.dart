import 'package:consumer_app/configs/theme/app_theme.dart';
import 'package:consumer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CoupTickConsumerApp());
}

class CoupTickConsumerApp extends StatelessWidget {
  const CoupTickConsumerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CoupTick',
      debugShowCheckedModeBanner: false,
      routerConfig: Pages.appRouter,
      theme: AppThemes.lightTheme,
    );
  }
}
