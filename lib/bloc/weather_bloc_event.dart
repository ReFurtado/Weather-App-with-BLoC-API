// ignore_for_file: prefer_const_constructors_in_immutables

part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

//Define uma classe de evento chamada FetchWeather que herda de WeatherBlocEvent.
class FetchWeather extends WeatherBlocEvent {

  //Variável que armazena informações de posição (como latitude e longitude).
  final Position position;

  //O construtor recebe um parâmetro chamado position.
  FetchWeather(this.position); 

  //Especifica que apenas a propriedade 'position' deve ser usada para comparação.
  @override
  List<Object> get props => [position];
}
