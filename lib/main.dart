import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logmax/core/colors.dart';
import 'package:logmax/data/auth_data/login_data/login_bloc.dart';

import 'core/splash_screen.dart';
import 'data/auth_data/sign_up_data/sign_up_bloc.dart';
import 'data/profile_data/profile_get_data/profile_get_bloc.dart';
import 'data/profile_data/profile_update_data/profile_update_bloc.dart';

Future<void> main() async {
  final Dio dio = Dio();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
        BlocProvider<ProfileGetBloc>(create: (context) => ProfileGetBloc()),
        BlocProvider<ProfileUpdateBloc>(create: (context) => ProfileUpdateBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: appColor,
      statusBarIconBrightness: Brightness.light,
    ));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}

