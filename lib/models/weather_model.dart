class WeatherModel{
  double? temp;
   int? hum;
  WeatherModel({required this.temp,required this.hum});
  WeatherModel.fromJson(Map<String ,dynamic> json){
    temp = (json['main']['temp'] as num).toDouble() - 273.15;
    hum = json['main']['humidity'];
  }
}