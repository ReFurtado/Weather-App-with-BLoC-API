import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../data/data_app.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {

  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    // Quando um evento é disparado, esta função é executada.
    on<WeatherBlocEvent>((event, emit) async {
      //Emite o estado "Carregando" para mostrar que uma operação está em andamento.
      emit(WeatherBlocLoading());

      try {
        //Obtém os dados meteorológicos com base na latitude e longitude da localização.
        Weather weather = await _getWeather();

        //Emite o estado "Sucesso" com os dados meteorológicos obtidos.
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        //Em caso de erro, emite o estado "Falha".
        emit(WeatherBlocFailure());
      }
    });
  }

  Future<Weather> _getWeather() async {
    //Obtém a localização atual do dispositivo.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    //Cria uma instância para obter os dados meteorológicos com uma chave de API.
    WeatherFactory wf = WeatherFactory(API_KEY, language: Language.PORTUGUESE_BRAZIL);

    //Obtém os dados meteorológicos com base na latitude e altitude da localização.
    Weather weather = await wf.currentWeatherByLocation(
      position.latitude,
      position.longitude,
    );
    //print(weather);

    return weather;
  }
}
