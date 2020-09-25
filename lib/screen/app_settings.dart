import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/bloc/appbar/appbar_bloc.dart';
import 'package:todo_list/bloc/appbar/appbar_event.dart';
import 'package:todo_list/bloc/appbar/appbar_state.dart';
import 'package:todo_list/common/theme_manager.dart';

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final AppState initialThemeState = themeNotifier.getInitialState();

    return BlocProvider(
        create: (context) => AppBloc(themeState: initialThemeState),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
            ),
            body: Column(
              children: [
                AppTheme(),
                new Divider(
                  color: Colors.black45,
                  thickness: 1.0,
                )
              ],
            ),
          );
        }));
  }
}

class AppTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state is DarkThemeState) {
        return ThemeSwitchWidget(true);
      }
      return ThemeSwitchWidget(false);
    });
  }
}

class ThemeSwitchWidget extends StatelessWidget {
  final bool switchValue;

  ThemeSwitchWidget(this.switchValue);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Dark Mode"),
          Switch(
              value: switchValue,
              onChanged: (val) {
                final String mode = themeNotifier.getMode();
                BlocProvider.of<AppBloc>(context).add(SwitchThemeEvent(mode));
                themeNotifier.toggleThemeMode();
              })
        ],
      ),
    );
  }
}
