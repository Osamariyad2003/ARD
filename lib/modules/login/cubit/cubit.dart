import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaza_barcode/screens/login/cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // LoginModel loginModel;



  void userLogin({
    required String email,
    required String password, required BuildContext context,
  })
  {
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value)
    {

      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

  //  Future<void>  signInwithGoogle()async{
  //
  //
  //   try{
  //     final userAccount = await googleSignIn.signIn();
  //     if(userAccount == null) return null;
  //
  //     final GoogleSignInAuthentication google_auth = await userAccount.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: google_auth.accessToken,
  //       idToken: google_auth.idToken,
  //     );
  //     final user_credential = await FirebaseAuth.instance.signInWithCredential(credential);
  //     emit(GoogleLoginSuccessState(user_credential.user!.uid));
  //
  //   }catch(e){
  //   }
  //
  // }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ChangePasswordVisibilityState());
  }
}