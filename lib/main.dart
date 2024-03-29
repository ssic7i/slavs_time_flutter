import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
import 'work_dates.dart' as slav_time_lib;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _timer_started = false;
//  var slav_time_obj = new slav_time_lib.slav_time();
  var slav_time_obj;

  String _screen_name = 'time';
  Map<String, dynamic> json_data = {};
  String _current_lang = 'ru';
  int _add_years = 0;
  String _year_name = '';
  int _year_num = 0;
  String _age_description = "";
  String data_json = "";
  int file_timezone = 2;

  TextStyle base_textStyle40 = new TextStyle(
      inherit: true,
      fontSize: 35.0,
      color: Colors.blueGrey,
      );

  TextStyle base_textStyle10 = new TextStyle(
    inherit: true,
    fontSize: 8.0,
    color: Colors.deepOrange,
  );

  TextStyle base_textStyle_age_info = new TextStyle(
    inherit: true,
    fontSize: 20.0,
//    color: Colors.deepOrange,
  );

  Future<String> getFileData_years(String langName) async {
    return await rootBundle.loadString('string_dir/' + langName + '_texts.json');
  }

  Future<File> _getTimezoneFile() async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/saved_tz.txt');
  }

  Future<File> _getLangFile() async {
    // get the path to the document directory.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/saved_lang.txt');
  }

  Future<int> _readTimezoneValue() async {
    try {
      File file = await _getTimezoneFile();
      // read the variable as a string from the file.
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return file_timezone;
    }
  }

  Future<String> _readLangValue() async {
    try {
      File file = await _getLangFile();
      // read the variable as a string from the file.
      String contents = await file.readAsString();
      print('_readLangValue->'+ contents);
      return contents.trim();
    } on FileSystemException {
      return _current_lang;
    }
  }

  Future<Null> _write_lang() async{
    await (await _getLangFile()).writeAsString(_current_lang);
  }

  Future<Null> _write_tz() async{
    await (await _getTimezoneFile()).writeAsString('$file_timezone');
  }
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

  void _show_year_info(){
    _screen_name = 'year_info';
  }

  void _show_time(){
    _screen_name = 'time';
  }

  void _show_settings(){
    _screen_name = 'settings';
  }

  void _up_timezone(){
    file_timezone += 1;
    if (file_timezone > 13){
      file_timezone = -11;
    }
    _write_tz();
  }

  void _change_lang(){
    print('current language: ' + _current_lang);
    if (_current_lang == 'ru'){
      _current_lang = 'en';
    } else{
      _current_lang = 'ru';
    }
    print('new lang: ' + _current_lang);
    _write_lang();

    getFileData_years(_current_lang).then((String value){
      print('getting file data(change lang)');
      print('current lang: ' + _current_lang);
      data_json = value;
      json_data = jsonDecode(data_json);
      _initial_set_parsed_data();
    },
        onError: (e) {
          print('file not prepared');
          data_json = 'exeption ${e}';
          json_data = {};
        }
    );

  }

  void _down_timezone(){
    file_timezone -= 1;
    if (file_timezone < -11){
      file_timezone = 13;
    }
    _write_tz();
  }

  void _get_timezone() async{
    file_timezone = await getCurrentTimezone();
    _write_tz();
  }

  void _change_year(){
    _year_num += 1;
    if (_year_num > 13){
      _year_num = 0;
    }
    if(json_data == null) {
      _add_years = 0;
      _year_name = "";
      _age_description = "";
    } else {
      _add_years = json_data['years'][_year_num.toString()]['add_years'];
      _year_name = json_data['years'][_year_num.toString()]['year_name'];
      _age_description = json_data['years'][_year_num.toString()]['age_description'];
    }
  }

  void _initial_set_parsed_data(){
    _add_years = json_data['years'][_year_num.toString()]['add_years'];
    _year_name = json_data['years'][_year_num.toString()]['year_name'];
    _age_description = json_data['years'][_year_num.toString()]['age_description'];
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
  String hours_count_name = '';
  String chasty_count_name = '';
  String doly_count_name = '';
  String current_month_name = '';
  String current_month_description = '';
  String hour_name = '';
  String hour_description = '';
  String day_description = '';
  String day_patron = '';




  void handleTimeout(Timer tmp) {  // callback function
    setState(()
    {
      current_time_string = new DateTime.now().toString();
      slav_time_obj = new slav_time_lib.slav_time(new_timezone: file_timezone);
//      slav_time_obj.update_time();
      _days_names = slav_time_obj.days_names;
      current_time_string_slav_hours = slav_time_obj.hour.toString();
      current_time_string_slav_chast = slav_time_obj.chast.toString();
      current_time_string_slav_doley = slav_time_obj.doly.toString();
      current_time_string_slav_year = (slav_time_obj.year_spsc + _add_years).toString();
      current_time_string_slav_date = slav_time_obj.day.toString();
      current_time_string_slav_year_roud_life = slav_time_obj.year_in_round_life.toString();
      current_time_string_slav_year_roud_years = slav_time_obj.year_in_round_years.toString();
      if(json_data == null){
        current_time_string_slav_day_name = "";
        current_month_name = "";
        current_month_description = "";
        hour_name = "";
        hour_description = "";
        day_description = "";
        day_patron = "";
      } else {
        if (json_data.containsKey('day')) {
          current_time_string_slav_day_name = json_data['day'][slav_time_obj.day_num.toString()]['name'];
          current_month_name = json_data['month'][slav_time_obj.month.toString()]['name'];
          current_month_description = json_data['month'][slav_time_obj.month.toString()]['description'];
          hour_name = json_data['hour'][slav_time_obj.hour.toString()]['name'];
          hour_description = json_data['hour'][slav_time_obj.hour.toString()]['description'];
          day_description = json_data['day'][slav_time_obj.day_num.toString()]['description'];
          day_patron = json_data['day'][slav_time_obj.day_num.toString()]['patron'];
        } else {
          current_time_string_slav_day_name = "";
          current_month_name = "";
          current_month_description = "";
          hour_name = "";
          hour_description = "";
          day_description = "";
          day_patron = "";
        }
      }

      hours_count_name = 'часов';
      if (slav_time_obj.hour > 4) {
        hours_count_name = 'часов';
      } else {
        if (slav_time_obj.hour == 1) {
          hours_count_name = 'час';
        } else {
          hours_count_name = 'часа';
        }
      }

      chasty_count_name = 'частей';
      if (current_time_string_slav_chast.endsWith('1') && slav_time_obj.chast != 11 ){
        chasty_count_name = 'часть';
      }
      if (current_time_string_slav_chast.endsWith('2') && slav_time_obj.chast != 12 ){
        chasty_count_name = 'части';
      }
      if (current_time_string_slav_chast.endsWith('3') && slav_time_obj.chast != 13 ){
        chasty_count_name = 'части';
      }
      if (current_time_string_slav_chast.endsWith('4') && slav_time_obj.chast != 14 ){
        chasty_count_name = 'части';
      }

      doly_count_name = 'долей';
      if (current_time_string_slav_doley.endsWith('1') && slav_time_obj.doly != 11){
        doly_count_name = 'доля';
      }
      if (current_time_string_slav_doley.endsWith('2') && slav_time_obj.doly != 12){
        doly_count_name = 'доли';
      }
      if (current_time_string_slav_doley.endsWith('3') && slav_time_obj.doly != 13){
        doly_count_name = 'доли';
      }
      if (current_time_string_slav_doley.endsWith('4') && slav_time_obj.doly != 14){
        doly_count_name = 'доли';
      }

    }
    );
  }

  Future<int> getCurrentTimezone() async {
    try{
      var locationPermission = await Geolocator.requestPermission();
      print(locationPermission);
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // Print the user's latitude and longitude.
      print(position.latitude);
      print(position.longitude);
      print(position.timestamp);
      var local_time = DateTime.now();
      int local_tz = local_time.timeZoneOffset.inHours;
      print(local_time);

      // Print the hours.
      print(local_tz);

      return local_tz;
      //ToDo: add calculation by gps sphere coordinates
    } catch (e){
      return 0;
    }
  }

  void start_timer(){
    new Timer.periodic(const Duration(milliseconds: 1000), handleTimeout);
    print('timer started');
    _readTimezoneValue().then((int tzVal){
        file_timezone = tzVal;
      }
    );

    _readLangValue().then((value){
      _current_lang=value;
      getFileData_years(_current_lang).then((String value){
        print('getting file data(start timer)');
        print('current lang: ' + _current_lang);
        data_json = value;
        json_data = jsonDecode(data_json);
        _initial_set_parsed_data();
      },
          onError: (e) {
            print('file not prepared');
            data_json = 'exeption ${e}';
            json_data = {};
          }
      );
      }
    );
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

    var bodyScreen = new Center();

    switch (_screen_name){
    case 'time':
      bodyScreen = new Center(
        child: new ListView(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('${current_time_string_slav_hours} ${hours_count_name}', style: base_textStyle40, ),
            new Text('${current_time_string_slav_chast} ${chasty_count_name}', style: base_textStyle40, ),
            new Text('${current_time_string_slav_doley} ${doly_count_name}', style: base_textStyle40, ),
            new Text('${hour_name}, ${hour_description}', style: base_textStyle40, textScaleFactor: 0.6,),
            new Text('${current_time_string_slav_day_name}, ${day_description}', style: base_textStyle40, textScaleFactor: 0.6,),
            new Text('${current_time_string_slav_date}-й день', style: base_textStyle40, textScaleFactor: 0.8),
            new Text("${current_month_name}. ${current_month_description}", style: base_textStyle40, textScaleFactor: 0.6,),
            new Text('${current_time_string_slav_year_roud_life}-ое лето в круге жизни', style: base_textStyle40, textScaleFactor: 0.6, ),
            new Text('${current_time_string_slav_year_roud_years}-ое лето в круге лет', style: base_textStyle40, textScaleFactor: 0.6, ),
            new Text('${current_time_string_slav_year} лето от ${_year_name}', style: base_textStyle40, textScaleFactor: 0.6,),
            new Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new IconButton(icon: const Icon(Icons.calendar_today), onPressed: _change_year),
              new IconButton(icon: const Icon(Icons.info), onPressed: _show_year_info),
              new IconButton(icon: const Icon(Icons.settings), onPressed: _show_settings),
            ],
            )

//            new IconButton(icon: const Icon(Icons.calendar_today), onPressed: _show_calendar)
          ],
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
        ),
      );
      break;
    case 'calendar':
      var headerArray = <Widget>[];
      for( String day_name in _days_names){
        headerArray.add(new Text(day_name, style: base_textStyle10, softWrap: false,));
      }
      var tableHeader = new TableRow(children: headerArray);
      bodyScreen = new Center(
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Table(children: <TableRow>[tableHeader], defaultColumnWidth: new FixedColumnWidth(30.0),),
            new IconButton(icon: const Icon(Icons.arrow_back), onPressed: _show_time)
          ],
        ),
      );
      break;
    case 'year_info':
      bodyScreen = new Center(
        child: new Align(
          alignment: new Alignment(-1.0, -1.0),
          child: new ListView(
            children: <Widget>[
              new Align(
                alignment: new Alignment(-1.0, -1.0),
                child: new IconButton(icon: const Icon(Icons.arrow_back), onPressed: _show_time),
              ),
              new Text(
                _age_description,
                textAlign: TextAlign.left,
                softWrap: true,
                style: base_textStyle_age_info,
              ),
            ],
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          ),
        )
      );
      break;
    case 'settings':
      String timezoneText =  "${file_timezone}";
      if (file_timezone > 0){
        timezoneText = "+${timezoneText}";
      }
      bodyScreen = new Center(
          child: new Align( 
            alignment: new Alignment(-1.0, -1.0),
            child: new ListView(
              children: <Widget>[
                new Align(
                  alignment: new Alignment(-1.0, -1.0),
                  child: new IconButton(icon: const Icon(Icons.arrow_back), onPressed: _show_time),
                ),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Часовой пояс:",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: base_textStyle_age_info,
                    ),
                    new Text(
                      timezoneText,
                      textAlign: TextAlign.left,
                      softWrap: false,
                      style: base_textStyle_age_info,
                    ),
                    new IconButton(icon: const Icon(Icons.add), onPressed: _up_timezone),
                    new IconButton(icon: const Icon(Icons.remove), onPressed: _down_timezone),
                  ],
                ),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Lang:",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: base_textStyle_age_info,
                    ),
                    new Text(
                      _current_lang,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: base_textStyle_age_info,
                    ),
                    new IconButton(icon: const Icon(Icons.language), onPressed: _change_lang),
                  ],
                ),
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Calc Timezone:",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: base_textStyle_age_info,
                    ),
                    new Text(
                      _current_lang,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: base_textStyle_age_info,
                    ),
                    new IconButton(icon: const Icon(Icons.edit_location_rounded), onPressed: _get_timezone),
                  ],
                ),
              ],
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
            )
          )
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
      body: bodyScreen
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
