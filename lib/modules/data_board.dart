import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa/companets/colors.dart';
import 'package:nasa/companets/constants.dart';
import 'package:nasa/companets/routing.dart';
import 'package:nasa/cubit/cubit.dart';
import 'package:nasa/cubit/states.dart';
import 'package:nasa/modules/heat_map.dart';
import 'package:nasa/modules/not.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Dash_Board extends StatefulWidget {
  const Dash_Board({super.key});

  @override
  State<Dash_Board> createState() => _Dash_BoardState();
}

class _Dash_BoardState extends State<Dash_Board> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeCubit,HomeStates>(
        listener: (BuildContext context, HomeStates state) {
          var cubit =HomeCubit.get(context);

          if(state is HomeGetWeatherSuccessState && cubit.weather!.hum > 90 ){
            LocalNotificationService().showNotification(id: 1, title: "Smh", body: "be CareFul");
          }
        },
        builder: (BuildContext context, HomeStates state){
          var cubit =HomeCubit.get(context);
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 400,
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(25),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics:
                    BouncingScrollPhysics(), // Prevent scrolling inside GridView
                    children: [
                      ChartWidget(
                          chart: CircularPrecentage(
                              value: cubit.output[0].toInt() ?? 0, // Provide default value
                              factor: "Drought Risk"
                          )
                      ),
                      ChartWidget(
                          chart: CircularPrecentage(
                              value: cubit.output[1].toInt() ?? 0, // Provide default value
                              factor: "Disease Risk"
                          )
                      ),
                      ChartWidget(
                          chart: CircularPrecentage(
                              value: cubit.output[2].toInt() ?? 0, // Provide default value
                              factor: "Frost Risk"
                          )
                      ),
                      ChartWidget(
                          chart: CircularPrecentage(
                              value: cubit.weather?.temp ?? 0, // Provide default value
                              factor: "Temp"
                          )
                      ),
                      ChartWidget(
                          chart: CircularPrecentage(
                              value: cubit.output[3].toInt() ?? 0, // Provide default value
                              factor: "Plant Stress"
                          )
                      ),
                      ChartWidget(
                          chart: CircularPrecentage(
                              value: cubit.weather?.hum ?? 0, // Provide default value
                              factor: "Humidity"
                          )
                      ),
                    ],
                  ),
                ),
              Divider(
                color: Colors.grey, // The color of the line
                height: 10, // The space around the divider
                thickness: 2, // The thickness of the line
                indent: 10, // Left spacing from the divider's start
                endIndent: 10, // Right spacing from the divider's end
              ),
              // Other containers below GridView
              Text(
                "HEAT-MAPS",
                textAlign: TextAlign.center, // Aligns the text in the center
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),

              HeatMapTile(title:"Soil Moisture",icon: Icon(Icons.ac_unit_rounded),
                onTap: (){
                navigateTo(context, WebViewExample(link: "https://go.nasa.gov/482WxIM",));
                },
              ),
              Container(
                height: 10,
              ),
              HeatMapTile(title:"NDVI",icon: Icon(Icons.ac_unit_rounded), onTap: (){
                navigateTo(context, WebViewExample(link: "https://go.nasa.gov/4gWbOyU",));
              },),
              //     Color mainColor = HexColor("#168E6A");
              //     Color(0xFF292D32),
              // Color fieldColor  = HexColor("#B5B5B5");
            ],
          );

        },

      ),
    );
  }
}

class HeatMapTile extends StatelessWidget {
  HeatMapTile({required this.title, required this.icon, required this.onTap});

  final String title;
  final Icon icon;
  final VoidCallback onTap;  // Use VoidCallback for the onTap type

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: onTap,  // This will handle the tap action
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,  // Replace with your `mainColor`
            borderRadius: BorderRadius.circular(15),  // Adjust the radius as needed
          ),
          child: ListTile(
            // Remove the redundant onTap from ListTile
            minVerticalPadding: 20,
            leading: icon,  // Use the icon passed to the constructor
            title: Container(
              alignment: Alignment.center,
              child: Text(title),  // No need to use string interpolation for a single variable
            ),
          ),
        ),
      ),
    );
  }
}
class ChartWidget extends StatelessWidget {
  ChartWidget({required this.chart});
  final Widget chart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF292D32),
        borderRadius: BorderRadius.circular(15), // Correct usage
      ),
      height: 100, // Adjusted height for consistent layout
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          chart,
        ],
      ),
    );
  }
}

class CircularPrecentage extends StatelessWidget {
  final dynamic value;
  final String factor;
  CircularPrecentage({required this.value, required this.factor});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 8,
      percent: value / 100,
      center: Text(
        "$value%",
        style: TextStyle(
          fontSize: 25,
          color: Colors.white
        ),
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          Text(factor,style: TextStyle(color: Colors.white),),
        ],
      ),
      progressColor: mainColor,
    );
  }
}
