import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/cubit/bloc_observer.dart';
import 'package:nasa/cubit/cubit.dart';
import 'package:nasa/firebase_options.dart';
import 'package:nasa/modules/login/cubit/cubit.dart';
import 'package:nasa/modules/not.dart';
import 'package:nasa/modules/splash.dart';
import 'package:nasa/network/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await LocalNotificationService().initialize(); // Initialize notification service

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> LoginCubit()),
        BlocProvider(create: (context)=> HomeCubit()..getWeather())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

