import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaza_barcode/screens/home.dart';

import '../../components/constants.dart';
import '../../components/error_dialog.dart';
import '../../components/form_field.dart';
import '../../components/widgets.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LoginScreen extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          showToast(text: 'Login Successful', state: ToastStates.success);
          navigateAndFinish(context, HomeScreen()); // Navigate on success
        } else if (state is LoginErrorState) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ShowDialogError(
                title: "Login Failed",
                subTitle: state.error,
                functionPressed: () {
                  showToast(text: "Please try again", state: ToastStates.error);
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MainColor_two,
                  MainColor_one,
                ],
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Text('Login ',style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700,color: mainColor),),
                  SizedBox(height: 8,),
                  Text('Create An Account In Medicine Code',style:TextStyle(color: mainColor,fontSize: 15) ,),


                  MyFormField(
                    title: "Email",
                    hint: "Enter your email",
                    fill: grey_dot.withOpacity(0.1),
                    hintStyle: TextStyle(color: mainColor),
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    maxLines: 1,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  MyFormField(
                    title: "Password",
                    hint: "Enter your password",
                    fill: grey_dot.withOpacity(0.1),
                    hintStyle: TextStyle(color: mainColor,),
                    isPassword: cubit.isPassword,
                    type: TextInputType.visiblePassword,
                    controller: passwordController,
                    maxLines: 1,
                    suffixIcon: cubit.suffix,
                    suffixIconPressed: cubit.changePasswordVisibility,
                    validation: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  if (state is LoginLoadingState)
                    CircularProgressIndicator()
                  else
                    defaultButton("LOG IN",blue, () {

                      cubit.userLogin(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                      );
                      //

                    },context)

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}