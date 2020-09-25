import 'package:flutter/material.dart';
import 'package:todo_list/bloc/appbar/appbar_state.dart';
import 'package:todo_list/common/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.brown),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.white),
    dividerColor: Colors.white54,
  );

  String _themeMode;
  ThemeData _themeData;
  ThemeData getTheme() => _themeData;
  String getMode() => _themeMode;

  AppState getInitialState() {
    return (_themeMode == 'dark') ? DarkThemeState() : LightThemeState();
  }

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      _themeMode = value ?? 'light';
      if (_themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void toggleThemeMode() async {
    String currentMode = await StorageManager.readData('themeMode');
    _themeMode = (currentMode == 'dark') ? 'light' : 'dark';
    (_themeMode == 'dark') ? setDarkMode() : setLightMode();
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}