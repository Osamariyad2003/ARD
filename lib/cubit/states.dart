abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class HomeBottomNavState extends HomeStates {}

class HomeChangeModeState extends HomeStates {}

class HomeChangeLangState extends HomeStates {}

class HomeGetCurrentPostionState extends HomeStates {}
class HomeGetCurrentAddresState extends HomeStates {
  final String city;
  HomeGetCurrentAddresState(this.city);
}
class HomeGetWeatherLoadingState extends HomeStates {}

class HomeGetWeatherSuccessState extends HomeStates {}

class HomeGetWeatherErrorState extends HomeStates
{
  final String error;

  HomeGetWeatherErrorState(this.error);
}

class GetUserLoadingState extends HomeStates {}
class GetUserSuccessState extends HomeStates {}
class GetUserErrorState extends HomeStates {
  final String error;
  GetUserErrorState(this.error);
}





class SerachClickState extends HomeStates {}
class HomeReminderState extends HomeStates {}
class HomeChangeSwtichState extends HomeStates {}
class GetNotificationSuccess extends HomeStates{}