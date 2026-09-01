import 'package:driver_app/features/auth/view_model/login_view_model.dart';
import 'package:driver_app/features/splash/view/splash_view_model.dart';
import 'package:driver_app/features/splash/view_model/splash_view_model.dart';
import 'package:driver_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // =========================================================
  // FIREBASE INITIALIZATION
  // =========================================================

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // =========================================================
  // RUN APP
  // =========================================================

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SplashViewModel(),
        ),

        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        ),

        // OtpViewModel ko yahan global provider mat banao,
        // kyunki usko verificationId constructor me chahiye.
        // OtpScreen ke andar hi provider create hoga.
      ],
      child: const PatgolitoDriverApp(),
    ),
  );
}

class PatgolitoDriverApp extends StatelessWidget {
  const PatgolitoDriverApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patgolito Driver',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}