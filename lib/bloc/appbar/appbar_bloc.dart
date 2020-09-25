import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'appbar_event.dart';
import 'appbar_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppState themeState;
  AppBloc({this.themeState}) : super(themeState);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is SwitchThemeEvent) {
      String themeMode = event.themeMode;
      if (themeMode == 'light') {
        yield DarkThemeState();
      } else {
        yield LightThemeState();
      }
    }
  }
}
