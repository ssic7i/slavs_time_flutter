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
  int _add_years = 0;
  String _year_name = 'Сотворения Мира в Звёздном Храме';
  int _year_num = 0;
  String _age_description = """Сотворением Мира раньше называли заключение мирного договора между воюющими сторонами. В данном случае мирный договор был заключён между Славяно-Ариями и древними китайцами. Договор был заключён в 1й день первого месяца Лета 5500 от Великого похолодания. Победу одержали Славяно-Арии, по договору поверженные построили стену для обозначения границы. Построенную стену назвали Кий-Тай.""";

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

  void _show_year_info(){
    _screen_name = 'year_info';
  }

  void _show_time(){
    _screen_name = 'time';
  }

  void _change_year(){
    _year_num += 1;
    if (_year_num > 13){
      _year_num = 0;
    }

    switch (_year_num){
      case 0:
        _add_years = 0;
        _year_name = 'Сотворения Мира в Звёздном Храме';
        _age_description = """Сотворением Мира раньше называли заключение мирного договора между воюющими сторонами. В данном случае мирный договор был заключён между Славяно-Ариями и древними китайцами. Договор был заключён в 1й день первого месяца Лета 5500 от Великого похолодания. Победу одержали Славяно-Арии, по договору поверженные построили стену для обозначения границы. Построенную стену назвали Кий-Тай.""";
        break;
      case 1:
        _add_years = 5500;
        _year_name = 'Великой Стужи';
        _age_description = """Этот отсчёт связан с началом Великого Похолодания, которое связано с падением в Тихий океан осколков разрушенной Луны Фатты, у которой был период обращения 13 суток. Эта катастрофа отбросила Человечество в "Каменный век" """;
        break;
      case 2:
        _add_years = 32496;
        _year_name = '3-го Прибытия Вайтманы Перуна';
        _age_description = """Это исчисление ведёт отсчёт от третьего прибытия одного из Вышних Славяно-Арийских Богов Перуна. Он спустился на Небесной колеснице в район Асгарда и в течении 9 дней Жрецы и Вои общались с Перуном. Он поведал им Мудрость Мира Прави, которая была записана Волхвами на золотых пластинах.""";
        break;
      case 3:
        _add_years = 37036;
        _year_name = 'Сотворения Великого Коло Рассении';
        _age_description = """Исчисление от объединения Славяно-Арийских Родов для совместной жизни. Было несколько этапов заселения Мидгарда(Земли). Прибывшие селились в разных местах. В итоге Старшие Родов собрались вместе и сотворили Великий круг для совместной жизни и созидания.""";
        break;
      case 4:
        _add_years = 99270;
        _year_name = 'Основания Асгарда Ирийского';
        _age_description = """Асгардъ - означает "Город Богов". Ирийский - так как стоит на реке Ирий Тишайший, сокращённо Иртыш. Всего было 4 Асгардов:
- на северном полюсе. Затонул вместе с Северным материком
- в районе нынешнего Ашхабада
- в районе города Уппсала в Норвегии
- в районе Омской крепости, сейчас город Омск""";
        break;
      case 5:
        _add_years = 104298;
        _year_name = 'Великого Переселения из Даарии';
        _age_description = """Даария - континент на северном полюсе где долгое время жили наши предки после заселения. Материк затонул в результате потопа из-за воды и осколков разрушенной Луны Лели.
    Славяно-Арийские народы переселялись по перешейку образованным нынешними Уральскими горами в район Западно-Сибирской возвышенности.
    После переселения, которое заняло 16 лет, был основан праздник Пасхеть. Традиция красить и бить яйца символизировали погибшую луну(разбитое яйцо) и Даждьбога(целое яйцо), который уничтожил луну вместе с Кащеями, которые находились на ней и планировали уничтожить Мидгардъ(Землю).""";
        break;
      case 6:
        _add_years = 135482;
        _year_name = 'периода Трех Лун';
        _age_description = """Период когда вокруг Мидгардъ(Земли) вращалось три луны:
- Леля. Малая луна с периодом обращения 7 суток
- Фатта. Средняя луна с периодом обращения 13 суток
- Месяц. Большая луна с периодом обращения 29.5 суток
    Леля и Месяц - изначально луны Мидгардъ(Земли), Фатта - луна перемещённая от Земли Деи.
""";
        break;
      case 7:
        _add_years = 145858;
        _year_name = 'Асса Деи';
        _age_description = """Асса - битва Богов. Данное исчисление происходит от войны в Сварге. В битве участвовали люди, Арлеги,  Боги. В Мире людей против славян и арийцев воевали серые(Кащеи) со своими союзниками. До того как была заселена Мидгардъ была заселена Земля Сварога(Дея) и Земля Орея(Марс).
    Силы Мира Тьмы атаковали Дею с Лютиции(луна Деи), предварительно проникнув туда, но жрецы успели перенести Дею в иномирье, при этом удар по Деи отразился и разорвал Лютицию, на этом месте сейчас пояс астероидов, вращающийся по пятой орбите после Марса. Вторая луна Фатта уцелела. В результате взрыва была снесена часть атмосферы Марса и славяно-арийские рода переселились на Мидгардъ.
    После окончания Асса Деи часть побеждённых, оставшиеся без своей земли, находясь на звездолётах в космосе, попросили пощады и приземлиться на Мидгардъ. Предки разрешили и выделили земли схожие по климату с их родиной, а для адаптации перетащили луну Фатту с 5й орбиты и запустили с периодом в 13 суток.""";
        break;
      case 8:
        _add_years = 157522;
        _year_name = 'Времени Тары';
        _age_description = """Исчисление от времени когда Богиня Тара привезла с собой семена Священных Деревьев и дополнительно заселила Мидгардъ лесами.""";
        break;
      case 9:
        _add_years = 178258;
        _year_name = 'Времени Туле';
        _age_description = """Прибытие Расенов и заселение провинции Туле в Даарии.""";
        break;
      case 10:
        _add_years = 204178;
        _year_name = 'Времени Свага';
        _age_description = """Прибытие Святорусов из созвездия Большой Медведицы и заселение провинции Свагга в Даарии.""";
        break;
      case 11:
        _add_years = 266386;
        _year_name = 'Времени х’Арра';
        _age_description = """Прибытие х'Арийев из созвездия Орион""";
        break;
      case 12:
        _add_years = 453010;
        _year_name = 'Времени Дары';
        _age_description = """Прибытие Да'Арийцев из созвездия Малой Медведицы.""";
        break;
      case 13:
        _add_years = 596866;
        _year_name = 'Времени Трех Солнц';
        _age_description = """Исчисление ведётся от времени когда происходило сближение нашей солнечной системы с двумя другими, в результате чего можно было наблюдать ещё два солнца-гиганта серебристого и зелёного цвета, смотря на которые с Мидгардъ, были равны по величине с видимым нашим Ярило-Солнцем""";
        break;
//      case 14:
//        _add_years = 950000;
//        _year_name = 'Времени появления Богов';
//        _age_description = '';
//        break;
    }
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
      current_time_string_slav_year = (slav_time_obj.year_spsc + _add_years).toString();
      current_time_string_slav_date = slav_time_obj.day.toString();
      current_time_string_slav_year_roud_life = slav_time_obj.year_in_round_life.toString();
      current_time_string_slav_year_roud_years = slav_time_obj.year_in_round_years.toString();
      current_time_string_slav_day_name = slav_time_obj.day_name.toString();

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
            new Text('${current_time_string_slav_hours} ${hours_count_name}', style: base_textStyle40, ),
            new Text('${current_time_string_slav_chast} ${chasty_count_name}', style: base_textStyle40, ),
            new Text('${current_time_string_slav_doley} ${doly_count_name}', style: base_textStyle40, ),
            new Text('${current_time_string_slav_day_name}', style: base_textStyle40,),
            new Text('День ${current_time_string_slav_date}', style: base_textStyle40, ),
            new Text('${current_time_string_slav_year_roud_life}-ое лето в круге жизни', style: base_textStyle40, textScaleFactor: 0.7, ),
            new Text('${current_time_string_slav_year_roud_years}-ое лето в круге лет', style: base_textStyle40, textScaleFactor: 0.7, ),
            new Text('${current_time_string_slav_year} лето от ${_year_name}', style: base_textStyle40, textScaleFactor: 0.7,),
            new Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new IconButton(icon: const Icon(Icons.calendar_today), onPressed: _change_year),
              new IconButton(icon: const Icon(Icons.info), onPressed: _show_year_info),
            ],)

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
    case 'year_info':
      body_screen = new Center(
        child: new ListView(
          children: <Widget>[
            new IconButton(icon: const Icon(Icons.arrow_back), onPressed: _show_time),
            new Text(
              _age_description,
              textAlign: TextAlign.left,
              softWrap: true,
            ),
          ],
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
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
      body: body_screen
 // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
