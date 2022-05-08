import 'dart:io';
import 'dart:convert';

class slav_time{

  int hour = 0;
  int chast = 0;
  int doly = 0;
  var _current_date;

  int svarog_day = 0;
  int life_round = 0;
  int year_round = 0;
  int year = 0;
  int month = 0;
  int day = 0;

  int year_spsc = 0;
  int year_in_round_life = 0;
  int year_in_round_years = 0;
  String day_name = '';
  int day_num = 0;
  List days_names = ['Понедельникъ', 'Вторникъ', 'Тритейникъ', 'Четверикъ', 'Пятница', 'Шестица', 'Седьмица', 'Осьмица', 'Неделя'];
//  var timezone = new Duration(hours: 2);
  var timezone;
  slav_time({int new_timezone = 0}){ // constructor

    this.timezone = new Duration(hours: new_timezone);
    this._current_date = new DateTime.now().toUtc().add(this.timezone);
//    print('##################');
//    print(this._current_date);
    this._fill_time();
    this._fill_date();
    this._fill_day();
    // eval cur year cpsc
    this.year_spsc = this.year + 7520;
    // eval cur day
    this.year_in_round_life = (this.life_round-1) * (this.year_round-1) + this.year;
    this.year_in_round_years = this.year;
//    print();
  }

  slav_time.manual({int year: 2012, int month: 9, int day: 23, int hour: 18, int minute: 0, int second: 0, int new_timezone: 0}){
    if (new_timezone == null){
      this.timezone = new Duration(hours: new_timezone);
    }
    else{
      this.timezone = new Duration(hours: new_timezone);
    }

    this._current_date = new DateTime(year, month, day, hour, minute, second).toUtc().add(this.timezone);
    this._fill_time();
    this._fill_date();
    this._fill_day();
    // eval cur year cpsc
    this.year_spsc = this.year + 7520;
    // eval cur day
    this.year_in_round_life = (this.life_round-1) * (this.year_round-1) + this.year;
    this.year_in_round_years = this.year;
  }

  update_time(){
    this._current_date = new DateTime.now().toUtc().add(this.timezone);
    this._fill_time();
    this._fill_date();
    this._fill_day();
    // eval cur year cpsc
    this.year_spsc = this.year + 7520;
    // eval cur day
    this.year_in_round_life = (this.life_round-1) * (this.year_round-1) + this.year;
    this.year_in_round_years = this.year;
  }

  _fill_day(){
    DateTime base_date = new DateTime.utc(2012, 9, 22, 16, 0, 0).add(this.timezone);
    DateTime cur_date = this._current_date;
    int days_between_dates = (cur_date.difference(base_date).inDays);
    int day_num = (days_between_dates % 9) + 1;
//    print(day_num);
    if (day_num==1){
      this.day_name = 'Понедельникъ';
      this.day_num = 1;
    }
    if (day_num==2){
      this.day_name = 'Вторникъ';
      this.day_num = 2;
    }
    if (day_num==3){
      this.day_name = 'Тритейникъ';
      this.day_num = 3;
    }
    if (day_num==4){
      this.day_name = 'Четверикъ';
      this.day_num = 4;
    }
    if (day_num==5){
      this.day_name = 'Пятница';
      this.day_num = 5;
    }
    if (day_num==6){
      this.day_name = 'Шестица';
      this.day_num = 6;
    }
    if (day_num==7){
      this.day_name = 'Седьмица';
      this.day_num = 7;
    }
    if (day_num==8){
      this.day_name = 'Осьмица';
      this.day_num = 8;
    }
    if (day_num==9){
      this.day_name = 'Неделя';
      this.day_num = 9;
    }
  }

  _fill_time(){
    int cur_hour = this._current_date.hour;
    int cur_minute = this._current_date.minute;
    int cur_seconds = this._current_date.second;
    if(cur_hour>18)
    {
      cur_hour = cur_hour - 18;
    }
    else
    {
      cur_hour = cur_hour + 6;
    }

    int day_secs = cur_hour * 60 * 60 + cur_minute * 60 + cur_seconds;
    double all_doley = day_secs * 34.56;
//    print("${all_doley}");
    int conv_hour = all_doley ~/ (1296 * 144);
//    print("${conv_hour}");
    double ost_chastey_raw = all_doley % (1296 * 144);
    int ost_chastey = ost_chastey_raw.round();
    int chastey = ost_chastey ~/ 1296;
    int doley = ost_chastey % 1296;
//    print("${ost_chastey} ${ost_chastey_raw}");
//    print("${conv_hour} ${chastey} ${doley}");
    if (conv_hour == 0) {
      conv_hour = 16;
    }
    this.hour = conv_hour;
    this.chast = chastey;
    this.doly = doley;

  }

  _fill_date(){
    int __simple_year__ = 365;
    int __st_year__ = 369;
    int __one_round_years__ = __simple_year__ * 15 + __st_year__;
    int __one_round_life__ = __one_round_years__ * 9;
    int __one_svarogs_day__ = __one_round_life__ * 180;

    // Days in Svarogs day before 23.09.2012
    // 23.09.2012 starts 3 of 4 parts of Svarogs day
    int day_before_base = __one_svarogs_day__ ~/ 2;

    DateTime base_date = new DateTime.utc(2012, 9, 22, 16, 0, 0).add(this.timezone);//.add(new Duration(days: 1));
    DateTime cur_date = this._current_date;
    int days_between_dates = (cur_date.difference(base_date).inDays) - 1;

    int svarogs_days;
    int round_lifes;
    int round_years;
    int year;
    int month;
    int day;

    if((days_between_dates + day_before_base)  ~/ __one_svarogs_day__ > 0){
      int count_svarogs_days = (days_between_dates + day_before_base) ~/ __one_svarogs_day__;
      days_between_dates = __one_svarogs_day__ * count_svarogs_days - days_between_dates - day_before_base;
      svarogs_days = count_svarogs_days;
    }
    else {
      svarogs_days = 0;
    }

    svarogs_days = svarogs_days + 1;

    if(days_between_dates ~/ __one_round_life__ > 0) {
      round_lifes = days_between_dates ~/ __one_round_life__;
      days_between_dates = days_between_dates % __one_round_life__;
    }
    else {
      round_lifes = 0;
    }
    round_lifes  = round_lifes + 1;

    if(days_between_dates ~/ __one_round_years__ > 0) {
      round_years = days_between_dates ~/ __one_round_years__;
      days_between_dates = days_between_dates % __one_round_years__;
    }
    else {
      round_years = 0;
    }

    round_years = round_years + 1;

    if(days_between_dates ~/ (__simple_year__ * 15) > 0){
    // big year(16-th)
      days_between_dates = days_between_dates - (__simple_year__ * 15);
      year = 16;
      month = days_between_dates ~/ 41 + 1;
      day = days_between_dates % 41;
      //return svarogs_days, round_lifes, round_years, year, month, day
      this.svarog_day = svarogs_days;
      this.life_round = round_lifes;
      this.year_round = round_years;
      this.year = year;
      this.month = month;
      this.day = day;
    }
    else {
      // simple year
      int date;
      int corr_year;
      int days_in_cur_year;

      year = days_between_dates ~/ __simple_year__;
      corr_year = year + 1;
      days_in_cur_year = (days_between_dates - (year * __simple_year__)) + 1;
      days_in_cur_year = days_in_cur_year + 1;// because days_in_cur_year might be 0

      if (days_in_cur_year > __simple_year__){
        corr_year += 1;
        days_in_cur_year = days_in_cur_year - __simple_year__;
      }

      if ((days_in_cur_year >= 1) && (days_in_cur_year < 41+1)){
      // [1..41] 41
        month = 1;
        date = days_in_cur_year;
      } else if (days_in_cur_year >= 41+1 && days_in_cur_year < 41+1+40){
      // [42..81] 40
        month = 2;
        date = days_in_cur_year - 41;
      }
      else if( days_in_cur_year >= 41+1+40 && days_in_cur_year < 41+1+40+41)
      {
      // [82..122] 41
        month = 3;
        date = days_in_cur_year - 41 - 40;
      }
      else if (days_in_cur_year >= 41+1+40+41 && days_in_cur_year < 41+1+40+41+40)
      {
      // [123..162] 40
        month = 4;
        date = days_in_cur_year - 41 - 40 - 41;
      }
      else if( days_in_cur_year >= 41+1+40+41+40 && days_in_cur_year < 41+1+40+41+40+41)
      {
        // [163..203] 41
        month = 5;
        date = days_in_cur_year - 41 - 40 - 41 - 40;
      }
      else if( days_in_cur_year >= 41+1+40+41+40+41 && days_in_cur_year < 41+1+40+41+40+41+40){
        //: # [204..243] 40
        month = 6;
        date = days_in_cur_year - 41 - 40 - 41 - 40 - 41;
      }
      else if(days_in_cur_year >= 41+1+40+41+40+41+40 && days_in_cur_year < 41+1+40+41+40+41+40+41) {
        //: # [244..284] 41
        month = 7;
        date = days_in_cur_year - 41 - 40 - 41 - 40 - 41 - 40;
      }
      else if(days_in_cur_year >= 41+1+40+41+40+41+40+41 && days_in_cur_year < 41+1+40+41+40+41+40+41+40) {
        //[285..324] 40
        month = 8;
        date = days_in_cur_year - 41 - 40 - 41 - 40 - 41 - 40 - 41;
      }
      else { // range(41+1+40+41+40+41+40+41+40, 41+1+40+41+40+41+40+41+40+41) [325..365] 41
        month = 9;
        date = days_in_cur_year - 41 - 40 - 41 - 40 - 41 - 40 - 41 - 40;
      }
      day = date;
        //return svarogs_days, round_lifes, round_years, corr_year, month, day
      this.svarog_day = svarogs_days;
      this.life_round = round_lifes;
      this.year_round = round_years;
      this.year = corr_year;
      this.month = month;
      this.day = day;
    }


  }

  @override
  String  toString(){
    String out_str = "";
    out_str += ("Hour: ${this.hour}\n");
    out_str += ("Chast: ${this.chast}\n");
    out_str += ("Doley: ${this.doly}\n");
    out_str += ("---------------\n");
    out_str += ("Svarog day: ${this.svarog_day}\n");
    out_str += ("Life round: ${this.life_round}\n");
    out_str += ("Year round: ${this.year_round}\n");
    out_str += ("Year: ${this.year}\n");
    out_str += ("---------------\n");
    out_str += ("year_in_round_life: ${this.year_in_round_life}\n");
    out_str += ("year_in_round_years: ${this.year_in_round_years}\n");
    out_str += ("year_spsc: ${this.year_spsc}\n");
    out_str += ("---------------\n");
    out_str += ("Month: ${this.month}\n");
    out_str += ("Date: ${this.day}\n");
    out_str += ("Date: ${this.day_name}\n");
    return out_str;
  }
}



//main(){
//  var sl_obj = new slav_time();
//  print(sl_obj);
////  while(true) {
////    sleep(const Duration(seconds: 1));
////    print('---');
////    sl_obj.update_time();
////    print(sl_obj);
////  }
//
//}

