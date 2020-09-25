import 'package:calendar_strip/calendar_strip.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/todo/todo_bloc.dart';
import 'package:todo_list/services/todo_service.dart';

import '../list_screen.dart';

class MyHomePage extends StatelessWidget {
  // calendar setup
  final DateTime startDate = DateTime.now().subtract(Duration(days: 2));
  final DateTime endDate = DateTime.now().add(Duration(days: 2));
  final DateTime selectedDate = DateTime.now().subtract(Duration(days: 2));
  final List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];

  onSelect(data) {
    print("Selected Date -> $data");
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontStyle: FontStyle.normal,
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      )
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.white70 : Colors.white70;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 15, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  final int selectedIndex = 2;
  final TodoService todoService;
  MyHomePage({Key key, this.todoService});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TodoBloc(todoService: this.todoService),
        child: Builder(builder: (context) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CalendarStrip(
                  startDate: startDate,
                  endDate: endDate,
                  onDateSelected: onSelect,
                  dateTileBuilder: dateTileBuilder,
                  iconColor: Colors.white,
                  monthNameWidget: _monthNameWidget,
                  markedDates: markedDates,
                  containerDecoration: BoxDecoration(color: Colors.black45),
                  addSwipeGesture: true,
                ),
              ],
            )),
            bottomNavigationBar: FFNavigationBar(
              theme: FFNavigationBarTheme(
                barBackgroundColor: Colors.white,
                selectedItemBorderColor: Colors.transparent,
                selectedItemBackgroundColor: Colors.green,
                selectedItemIconColor: Colors.white,
                selectedItemLabelColor: Colors.black,
                showSelectedItemShadow: false,
                barHeight: 70,
              ),
              selectedIndex: selectedIndex,
              onSelectTab: (index) {
                // fire event
              },
              items: [
                FFNavigationBarItem(
                  iconData: Icons.calendar_today,
                  label: 'Today',
                ),
                FFNavigationBarItem(
                  iconData: Icons.assignment,
                  label: 'Reports',
                  selectedBackgroundColor: Colors.orange,
                ),
                FFNavigationBarItem(
                  iconData: Icons.add,
                  label: 'Add Task',
                  selectedBackgroundColor: Colors.purple,
                ),
                FFNavigationBarItem(
                  iconData: Icons.list,
                  label: 'List',
                  selectedBackgroundColor: Colors.blue,
                ),
                FFNavigationBarItem(
                  iconData: Icons.settings,
                  label: 'Settings',
                  selectedBackgroundColor: Colors.red,
                ),
              ],
            ),
          );
        }));
  }
}
