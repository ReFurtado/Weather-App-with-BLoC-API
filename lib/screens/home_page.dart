// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, annotate_overrides, must_be_immutable

import 'dart:ui';

import 'package:clima_app/bloc/weather_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //var ptBr = DateFormat('EEEE dd •', 'pt_BR');

  //Data atual
  DateTime now = DateTime.now();

  // Retorna um widget de imagem correspondente à condição climática.
  //https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2
  Widget getImage(int code) {
  switch (code) {
      case >= 200 && < 300 :
        return Image.asset(
          'assets/1.png',
         // color: c,
        );
      case >= 300 && < 400 :
        return Image.asset(
          'assets/2.png',
        );
      case >= 500 && < 600 :
        return Image.asset(
          'assets/3.png',
        );
      case >= 600 && < 700 :
        return Image.asset(
          'assets/4.png',
        );
      case == 800 :
        return Image.asset(
          'assets/6.png',
        );
      case >= 800 && < 804 :
        return Image.asset(
          'assets/8.png',
        );
      default:
      return Image.asset(
          'assets/7.png',
        );
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 1.6 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              //Degradê
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Container(
                  width: 700,
                  height: 300,
                  decoration: BoxDecoration(color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(12, -0.20),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-12, -0.20),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),

              //Info
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if(state is WeatherBlocSuccess) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          //Localização
                          Text(
                            '📍 ${state.weather.areaName}',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w400),
                          ),

                          SizedBox(height: 8), //Espaçamento

                          //Saudações
                          Text(
                            classHours(now.hour),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          //Imagem
                          getImage(state.weather.weatherConditionCode!),

                          //Temperatura
                          Center(
                            child: Text(
                              '${state.weather.temperature?.celsius!.round()}ºC',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          //Título
                          Center(
                            child: Text(
                              state.weather.weatherDescription!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 8), //Espaçamento

                          //Data
                          Center(
                            child: Text(
                              DateFormat("'Dia'  dd/mm  •  HH:mm").format(state.weather.date!),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(height: 34), //Espaçamento

                          //Temperaturas
                          Column(
                            children: [
                              //1º linha
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  //Dia
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/11.png',
                                        scale: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Amanhecer',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            DateFormat("HH:mm").format(state.weather.sunrise!),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            )
                                          )
                                        ],
                                      )
                                    ],
                                  ),

                                  //Noite
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/12.png',
                                        scale: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Anoitecer',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 4), //Espaçamento
                                          Text(
                                            DateFormat("HH:mm").format(state.weather.sunset!),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),

                              //Divisor
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 5),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),

                              //2º linha
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  //Máxima
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/13.png',
                                        scale: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Máxima',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${state.weather.tempMax!.celsius!.round()}ºC',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),

                                  //Minima
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/14.png',
                                        scale: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Mínima',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${state.weather.tempMin!.celsius!.round()}ºC',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }
                  
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Chamada de boas vindas
String classHours (int hour) {
  if (hour > 6 && hour < 12) {
    return 'Bom dia';
  } else if (hour >= 12 && hour < 18) {
    return 'Boa tarde';
  } else {
    return 'Boa noite';
  }
}