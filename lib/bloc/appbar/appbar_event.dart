import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {}

class SwitchThemeEvent extends AppEvent {
  final String themeMode;
  SwitchThemeEvent(this.themeMode);
  @override
  List<Object> get props => [];
}
