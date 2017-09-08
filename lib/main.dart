import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
import 'work_dates.dart' as slav_time_lib;
//import 'dart:ui';

void main() {
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // заголовок окна
      title: 'Славянское время',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting
        // the app, try changing the primarySwatch below to Colors.green
        // and then invoke "hot reload" (press "r" in the console where
        // you ran "flutter run", or press Run > Hot Reload App in
        // IntelliJ). Notice that the counter didn't reset back to zero;
        // the application is not restarted.
//        primarySwatch: Colors.blue,
        primarySwatch: Colors.teal,
      ),
      // надпись вверху
      home: new MyHomePage(title: 'Славяно-Арийское время'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful,
  // meaning that it has a State object (defined below) that contains
  // fields that affect how it looks.

  // This class is the configuration for the state. It holds the
  // values (in this case the title) provided by the parent (in this
  // case the App widget) and used by the build method of the State.
  // Fields in a Widget subclass are always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  bool _timer_started = false;
//  var slav_time_obj = new slav_time_lib.slav_time();
  var slav_time_obj;

  String _screen_name = 'time';

  TextStyle base_textStyle40 = new TextStyle(
      inherit: true,
      fontSize: 40.0,
      color: Colors.blueGrey,
      );

  TextStyle base_textStyle10 = new TextStyle(
    inherit: true,
    fontSize: 8.0,
    color: Colors.deepOrange,
  );

  void _run_all(){
    _incrementCounter();
//    if (_timer_started == false) {
//      start_timer();
//      _timer_started = true;
//    }

  }

  void _show_calendar(){
    _screen_name = 'calendar';
  }


  void _show_time(){
    _screen_name = 'time';
  }


  void _incrementCounter() {
    print("button pressed");
    setState(() {
      // This call to setState tells the Flutter framework that
      // something has changed in this State, which causes it to rerun
      // the build method below so that the display can reflect the
      // updated values. If we changed _counter without calling
      // setState(), then the build method would not be called again,
      // and so nothing would appear to happen.
    });
  }

  String current_time_string = 'Unknown';
  String current_time_string_slav_hours = '';
  String current_time_string_slav_chast = '';
  String current_time_string_slav_doley = '';
  String current_time_string_slav_year = '';
  String current_time_string_slav_date = '';
  String current_time_string_slav_year_roud_life = '';
  String current_time_string_slav_year_roud_years = '';
  String current_time_string_slav_day_name = '';
  List _days_names = [""];




  void handleTimeout(Timer tmp) {  // callback function
    setState(()
    {
      current_time_string = new DateTime.now().toString();
      slav_time_obj = new slav_time_lib.slav_time();
//      slav_time_obj.update_time();
      _days_names = slav_time_obj.days_names;
      current_time_string_slav_hours = slav_time_obj.hour.toString();
      current_time_string_slav_chast = slav_time_obj.chast.toString();
      current_time_string_slav_doley = slav_time_obj.doly.toString();
      current_time_string_slav_year = slav_time_obj.year_spsc.toString();
      current_time_string_slav_date = slav_time_obj.day.toString();
      current_time_string_slav_year_roud_life = slav_time_obj.year_in_round_life.toString();
      current_time_string_slav_year_roud_years = slav_time_obj.year_in_round_years.toString();
      current_time_string_slav_day_name = slav_time_obj.day_name.toString();
    }
    );
  }

  void start_timer(){
    new Timer.periodic(const Duration(milliseconds: 1000), handleTimeout);
    print('timer started');
  }

  @override
  Widget build(BuildContext context) {
     // This method is rerun every time setState is called, for instance
    // as done by the _incrementCounter method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    if (_timer_started == false) {
      _timer_started = true;
      start_timer();
    }

    var body_screen = new Center();

    switch (_screen_name){
    case 'time':
      body_screen = new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('${current_time_string_slav_hours} часов', style: base_textStyle40, ),
            new Text('${current_time_string_slav_chast} частей', style: base_textStyle40, ),
            new Text('${current_time_string_slav_doley} долей', style: base_textStyle40, ),
            new Text('${current_time_string_slav_day_name}', style: base_textStyle40,),
            new Text('День ${current_time_string_slav_date}', style: base_textStyle40, ),
            new Text('${current_time_string_slav_year_roud_life}-ое лето в круге жизни', style: base_textStyle40, textScaleFactor: 0.7, ),
            new Text('${current_time_string_slav_year_roud_years}-ое лето в круге лет', style: base_textStyle40, textScaleFactor: 0.7, ),
            new Text('${current_time_string_slav_year} лето от СМЗХ ', style: base_textStyle40, textScaleFactor: 0.7,),
//            new IconButton(icon: const Icon(Icons.calendar_today), onPressed: _show_calendar)
          ],
        ),
      );
      break;
    case 'calendar':
      var header_array = <Widget>[];
      for( String day_name in _days_names){
        header_array.add(new Text(day_name, style: base_textStyle10, softWrap: false,));
      }
      var table_header = new TableRow(children: header_array);
      body_screen = new Center(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Table(children: <TableRow>[table_header], defaultColumnWidth: new FixedColumnWidth(30.0),),
            new IconButton(icon: const Icon(Icons.arrow_back), onPressed: _show_time)
          ],
        ),
      );
      break;
    }

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that
        // was created by the App.build method, and use it to set
        // our appbar title.
        title: new Text(widget.title),
      ),
      body: body_screen
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
