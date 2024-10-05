class WeatherModel{
  late double temp;
  late int  hum;
  WeatherModel({required this.temp,required this.hum});
  WeatherModel.fromJson(Map<String ,dynamic> json){
    temp = (json['current']['temp_c'] ?? 0.0).toDouble();  // Use toDouble() to preserve decimal values
    hum = json['current']['humidity'] ?? 0;
  }
}