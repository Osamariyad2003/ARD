import 'package:flutter/material.dart';
import 'package:nasa/companets/colors.dart';
import 'package:nasa/companets/routing.dart';
import 'package:nasa/modules/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    // _checkToken();
    _navigateToNextScreen();
  }

  // Future<void> _checkToken() async {
  //   CacheHelper cacheHelper = CacheHelper();
  //   String? token = await  cacheHelper.readToken();
  //   setState(() {
  //     _isLoggedIn = token != null && token.isNotEmpty;
  //   });
  //   _navigateToNextScreen();
  // }
  void _navigateToNextScreen() {
    Future.delayed( Duration(seconds: 3), () {
      navigateAndFinish(context,LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.white ,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("aseets/images/logo.png",fit: BoxFit.cover,),

              SizedBox(height: 10),
              SizedBox(height: 10,),
              CircularProgressIndicator.adaptive(
                backgroundColor: mainColor,




              ),
            ],
          ),
        ),
      ),
    );
  }
}
