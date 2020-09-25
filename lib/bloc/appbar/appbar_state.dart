import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class DarkThemeState extends AppState {}
class LightThemeState extends AppState {}