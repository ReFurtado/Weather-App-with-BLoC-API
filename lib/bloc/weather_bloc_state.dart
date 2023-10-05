// ignore_for_file: prefer_const_constructors_in_immutables

part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();
  
  // Método necessário para a comparação de igualdade entre objetos.
  @override
  List<Object> get props => [];
}

// Classe que representa o estado inicial do BLoC.
final class WeatherBlocInitial extends WeatherBlocState {}

// Classe que representa o estado de carregamento de dados do BLoC.
final class WeatherBlocLoading extends WeatherBlocState {}

// Classe que representa o estado de falha ao buscar dados do BLoC.
final class WeatherBlocFailure extends WeatherBlocState {}

// Classe que representa o estado de sucesso ao buscar dados do BLoC.
final class WeatherBlocSuccess extends WeatherBlocState {

  // Propriedade para armazenar os dados da previsão do tempo
  final Weather weather; 

  // Construtor que recebe os dados da previsão do tempo como parâmetro.
  WeatherBlocSuccess(this.weather);

  // Sobrescreve o método 'props' para incluir 'weather' na comparação de igualdade.
  @override
  List<Object> get props => [weather];
}

