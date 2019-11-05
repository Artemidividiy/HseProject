import 'package:shared_preferences/shared_preferences.dart';
import './week_progress.dart';
import 'package:fl_chart/fl_chart.dart';

class User {
  static String username = "xiv";
  static int tasksToday = 0;

  static void oneMoreCompleted() {
    
    tasksToday++;
  }

  int sellTodayTasks() {
    if (DateTime.now().hour == 23 &&
        DateTime.now().minute == 59 &&
        DateTime.now().minute == 59)
      return tasksToday;
    else
      return null;
  }
  List<int> tasksOnWeek = List.generate(7, (i) {
    return 0;
  });

  


  void clearToday(int index) async {
    if (DateTime.now().hour == 0) {
      tasksOnWeek[index] = tasksToday;
      tasksToday = 0;
    }
  }

  static get Username => username;
}
