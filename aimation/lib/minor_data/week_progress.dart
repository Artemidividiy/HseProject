import 'package:flutter/material.dart';

enum dayOfWeek { sn, mn, ts, wn, th, fr, st }

class SubTasksPerDayOfTheWeek {
  final int subTasksCompleted;
  
  SubTasksPerDayOfTheWeek(this.subTasksCompleted, dayOfWeek); 


}
