import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nasa/companets/widgets.dart';
import 'package:nasa/cubit/states.dart';
import 'package:nasa/main.dart';
import 'package:nasa/models/user_model.dart';
import 'package:nasa/models/weather_model.dart';
import 'package:nasa/modules/chats/chat.dart';
import 'package:nasa/modules/crops.dart';
import 'package:nasa/modules/data_board.dart';
import 'package:nasa/modules/login/login.dart';
import 'package:nasa/network/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isClick = false;
  bool isDark = false;
  MyApp? myApp;
  String? cityname;
  List<dynamic> output=[];
  bool not_on = false;
  Position? currentPosition;
  String currentAddress ="Salinas Valley";

  List<Widget> bottomScreens = [
    Dash_Board(),
    Crops(),
    Chats()
  ];
  WeatherModel? weather;
  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(HomeBottomNavState());
  }

  List<dynamic> calculateStatistics() {
    double? T2M = weather?.temp ;
    double T2MDEW = 10;
    double RH2M = 93;
    double GWETPROF = 0.5;
    List<dynamic> o =[];
    double optimalSoilMoisture = 0.7; // 70%
    double irrigationNeed = (GWETPROF < optimalSoilMoisture)
        ? (1 - (GWETPROF / optimalSoilMoisture)) * 100
        : 0;
    o.add(irrigationNeed);
   int frostProtectionNeeded = ((T2MDEW < 0) ? 1 : 0)*100;
   o.add(frostProtectionNeeded);
   int  diseaseRisk = ((RH2M > 80 && T2M! < 20) ? 1 : 0)*100;
   o.add(diseaseRisk);
   double  plantStress = (RH2M / 100 + (optimalSoilMoisture - GWETPROF) / optimalSoilMoisture) * 50;
   o.add(plantStress);
   output = o;

   return output;
  }



  void getWeather() async{
    emit(HomeGetWeatherLoadingState());
      DioHelper.getData(
        url: 'current.json',
        query: {
          'q': "Salinas Valley",
          'key': '9f48512f38244b30836130923231009',
        },
      ).then((value) {
        if (value.statusCode == 200 && value.data != null) {
          print(value.data);
          weather = WeatherModel.fromJson(value.data);
          emit(HomeGetWeatherSuccessState());
        } else {
          ShowDialogError(title: 'Fetch error',subTitle: ' Failed to fetch weather data',);
          emit(HomeGetWeatherErrorState('Failed to fetch weather data'));
        }
      }).catchError((error) {
        if (error is DioError) {
          // Handle DioError specifically
          print('DioError: ${error.response?.statusCode} ${error.response?.statusMessage}');
          ShowDialogError(title: 'DioError', subTitle: '${error.response?.statusCode} ${error.response?.statusMessage}');

          if (error.response?.statusCode == 400) {
            ShowDialogError(title: 'Error', subTitle: 'Bad request. Please check your city name or API key.');
            emit(HomeGetWeatherErrorState('Bad request. Please check your city name or API key.'));
          } else {
            emit(HomeGetWeatherErrorState('Network error: ${error.message}'));
          }
        } else {
          emit(HomeGetWeatherErrorState('Unknown error: ${error.toString()}'));
        }
      });

  }
  UserModel? model;
  void getUserData(){
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(model?.uId).get().then((value){
      print(value.data());
      model = UserModel.fromJson(value.data() as Map<String,dynamic>);
      emit(GetUserSuccessState());
    }).catchError((error){
      print(error);
      emit(GetUserErrorState(error.toString()));
    });
  }

}