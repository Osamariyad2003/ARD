import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nasa/companets/colors.dart';
import 'package:nasa/cubit/cubit.dart';
import 'package:nasa/cubit/states.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      
      listener: (BuildContext context, HomeStates state) async{
        if(state is HomeGetWeatherSuccessState)
          HomeCubit.get(context).output = HomeCubit.get(context).calculateStatistics();
      },
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(condition: cubit.weather  !=null ,
          builder: (BuildContext context) {
            return Scaffold(
              appBar:AppBar(
                backgroundColor:Colors.white ,
                centerTitle: true,
                title:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pin_drop_outlined,color: mainColor,),
                    SizedBox(width: 8,),

                    Text("${cubit.currentAddress}",style: TextStyle(color: mainColor,fontSize: 23),),
                  ],
                ),
                actions: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpwxCN33LtdMLbWdhafc4HxabqpaU0qVbDxQ&s',
                    ),
                    backgroundColor: Colors.transparent,  // Optional, to avoid any background color issues
                  )

                ],
                elevation: 0,
              ),
              body: cubit.bottomScreens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar
                (currentIndex: cubit.currentIndex,
                  unselectedItemColor:  fieldColor,
                  selectedItemColor: mainColor,
                  onTap: (index){
                    cubit.changeBottomNavBar(index);
                  },items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.bar_chart,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: FaIcon(
                          FontAwesomeIcons.seedling
                      ),
                      label: 'Crops',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.chat,
                      ),
                      label: 'Chats',
                    ),
                  ]),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator(color: mainColor,)),

        );
        
      },
     
    );
  }
}
