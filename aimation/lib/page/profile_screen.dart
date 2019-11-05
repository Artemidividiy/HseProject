import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

int tasksCompleted;
double todays = 0;
int redrawWeekday = 0;
DateTime today = DateTime.now();

void dateCheceker() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  int previous = _prefs.getInt("lastCheckWeekDate");
  if (today.weekday != previous) {
    redrawWeekday = today.weekday - previous;
  }
  if (redrawWeekday > 0) {
    for (int i = previous; i != today.weekday; ++i) {
      filler(i);
    }
  }
  if (redrawWeekday < 0) {
    for (int i = 1; i != 8; ++i) {
      monday = 0;
      tuesday = 0;
      wednesday = 0;
      thursday = 0;
      friday = 0;
      saturnday = 0;
      sunday = 0;
      filler(i);
    }
  }
  filler(previousDay);
  
}

const List<String> weekDayKeys = [
  "mondayKey",
  "tuesdayKey",
  "thursdayKey",
  "fridayKey",
  "SaturdayKey",
  "SundayKey"
];

void filler(i) {
  switch (i) {
    case 1:
      sunday = todays;
      break;
    case 2:
      monday = todays;
      break;
    case 3:
      tuesday = todays;
      break;
    case 4:
      wednesday = todays;
      break;
    case 5:
      thursday = todays;
      break;
    case 6:
      friday = todays;
      break;
    case 7:
      saturnday = todays;
      break;
  }
  todays = 0;
}
double previousDay;

double monday;
double tuesday;
double wednesday;
double thursday;
double friday;
double saturnday;
double sunday;

class _ProfilePageState extends State<ProfilePage> {
  void _readTodays() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      todays = _prefs.getDouble("todays") ?? 0;
    });
  }

  void _readMonday() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      monday = _prefs.getDouble(weekDayKeys[0]) ?? 0;
    });
  }

  void _readTuesday() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      tuesday = _prefs.getDouble(weekDayKeys[1]) ?? 0;
    });
  }

  void _readWednesday() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      wednesday = _prefs.getDouble(weekDayKeys[2]) ?? 0;
    });
  }

  void _readThursday() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      thursday = _prefs.getDouble(weekDayKeys[3]) ?? 0;
    });
  }

  void _readFriday() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      friday = _prefs.getDouble(weekDayKeys[4]) ?? 0;
    });
  }

  void _readSaturday() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      saturnday = _prefs.getDouble(weekDayKeys[5]) ?? 0;
    });
  }

  void _readSunday() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      sunday = _prefs.getDouble(weekDayKeys[6]) ?? 0;
    });
  }

  void _readProgress() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      tasksCompleted = _prefs.getInt("tasksCompleted") ?? 0;
    });
  }

  void _readPrevious() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      previousDay = _prefs.getDouble("before") ?? 0;
    });
  }
  static const tasksCompletedKey = "taskCompletedKey";

  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = Duration(milliseconds: 250);

  StreamController<BarTouchResponse> barTouchedResultStreamController;

  int touchedIndex;

  @override
  void initState() {
    super.initState();
    dateCheceker();
    _readPrevious();
    _readProgress();
    _readTodays();
    _readMonday();
    _readTuesday();
    _readWednesday();
    _readThursday();
    _readFriday();
    _readSaturday();
    _readSunday();
    barTouchedResultStreamController = StreamController();
    barTouchedResultStreamController.stream
        .distinct()
        .listen((BarTouchResponse response) {
      if (response == null) {
        return;
      }

      if (response.spot == null) {
        setState(() {
          touchedIndex = -1;
        });
        return;
      }

      setState(() {
        if (response.touchInput is FlLongPressEnd) {
          touchedIndex = -1;
        } else {
          touchedIndex = response.spot.touchedBarGroupPosition;
        }
      });
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "statistics",
          style: TextStyle(fontFamily: 'Hind' , fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.purple[300],
                child: ListTile(
                  isThreeLine: true,
                  leading: Icon(
                    Icons.alarm_add,
                    size: 72.0,
                    color: Colors.white,
                  ),
                  onLongPress: () => setState(() {
                    Clipboard.setData(
                        new ClipboardData(text: "this text is from flutter"));
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      backgroundColor: Colors.deepPurple,
                      content: Text("copied to clipboard!"),
                      elevation: 120,
                    ));
                  }),
                  title: Text(
                    "You have completed $tasksCompleted",
                    style: TextStyle(fontFamily: 'Hind', color: Colors.white),
                  ),
                  subtitle: Text(
                    "Not bad! Hope, you enjoy, using this app 🙂",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.yellow[300],
                child: ListTile(
                  isThreeLine: true,
                  leading: Icon(
                    Icons.alarm_on,
                    size: 72.0,
                    color: Colors.grey[400],
                  ),
                  onLongPress: () => setState(() {
                    Clipboard.setData(new ClipboardData(
                        text: "I've done ${int.tryParse(todays.toString())} tasks today"));
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      backgroundColor: Colors.deepPurple,
                      content: Text("copied to clipboard!"),
                      elevation: 120,
                    ));
                  }),
                  title: Text(
                    "You have completed 7",
                    style:
                        TextStyle(fontFamily: 'Hind', color: Colors.grey[400]),
                  ),
                  subtitle: Text(
                    "Not bad! Hope, you enjoy, using this app 🙂",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    color: const Color(0xff81e5cd),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                'Completed subtasks',
                                style: TextStyle(
                                    color: const Color(0xff0f4a3c),
                                    fontSize: 24,
                                    fontFamily: 'Hind',
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'activity',
                                style: TextStyle(
                                    color: const Color(0xff379982),
                                    fontSize: 18,
                                    fontFamily: 'Hind',
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: FlChart(
                                    swapAnimationDuration: animDuration,
                                    chart: BarChart(mainBarData()),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
  }) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        y: isTouched ? y + 1 : y,
        color: isTouched ? Colors.yellow : barColor,
        width: width,
        isRound: true,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: 20,
          color: barBackgroundColor,
        ),
      ),
    ]);
  }

  void _saveMo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble(weekDayKeys[0], monday);
  }
  void _saveTu() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble(weekDayKeys[1], tuesday);
  }
  void _saveWe() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble(weekDayKeys[2], wednesday);
  }
  void _saveTh() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble(weekDayKeys[3], thursday);
  }
  void _saveFr() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble(weekDayKeys[4], friday);
  }
  void _saveSa() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble(weekDayKeys[5], saturnday);
  }
  void _saveSu() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble(weekDayKeys[6], sunday);
  }

  void _savePrevios() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setDouble("before", todays);
  }

  @override
  void dispose() {
    super.dispose();
    _saveMo();
    _saveTu();
    _saveWe();
    _saveTh();
    _saveFr();
    _saveSa();
    _saveSu();
    barTouchedResultStreamController.close();
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 7, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 3, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 2, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 4, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 1, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 0, isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: TouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                String weekDay;
                switch (touchedSpot.spot.x.toInt()) {
                  case 0:
                    weekDay = 'Monday';
                    break;
                  case 1:
                    weekDay = 'Tuesday';
                    break;
                  case 2:
                    weekDay = 'Wednesday';
                    break;
                  case 3:
                    weekDay = 'Thursday';
                    break;
                  case 4:
                    weekDay = 'Friday';
                    break;
                  case 5:
                    weekDay = 'Saturday';
                    break;
                  case 6:
                    weekDay = 'Sunday';
                    break;
                }
                return TooltipItem(
                    weekDay + '\n' + (touchedSpot.spot.y - 1).toString(),
                    TextStyle(color: Colors.yellow));
              }).toList();
            }),
        touchResponseSink: barTouchedResultStreamController.sink,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Hind',
                fontWeight: FontWeight.bold,
                fontSize: 14),
            margin: 16,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'M';
                case 1:
                  return 'T';
                case 2:
                  return 'W';
                case 3:
                  return 'T';
                case 4:
                  return 'F';
                case 5:
                  return 'S';
                case 6:
                  return 'S';
                default:
                  return '';
              }
            }),
        leftTitles: const SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
