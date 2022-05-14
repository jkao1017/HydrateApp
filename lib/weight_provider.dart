import 'package:flutter/material.dart';

var d = DateTime.now();
var weekday = d.weekday;


class Weight with ChangeNotifier{
  Map<String,int> map = {'Mon':1,'Tue':2,'Wed':3,'Thu':4,'Fri':5,'Sat':6,'Sun':7};
  int _waterOZ = 0;
  int _waterML = 0;
  int _visualOZ = 0;
  int _visualML = 0;
  List<String> _days = [];
  bool _isOZ = true;
  bool _isPound = true;
  List<String> get days => _days;
  int get waterOZ => _waterOZ;
  int get waterML => _waterML;
  int get visualOZ => _visualOZ;
  int get visualML => _visualML;
  bool get isPound => _isPound;
  bool get isOZ => _isOZ;

  void decrement(int water, bool isOZ){
    if(isOZ){
      _isOZ = isOZ;
      _visualOZ = _visualOZ - water;
      _visualML = _visualML - (water * 29.57353).floor();
    }else{
      _isOZ = isOZ;
      _visualML = _visualML - water;
      _visualOZ = _visualOZ - (water/29.57353).floor();
    }
  }

  void reset(){
    _visualOZ = waterOZ;
    _visualML = waterML;
  }

  void setWeight(double weight, bool isPound){
    if(isPound){
      _isPound = isPound;
      _waterOZ = (weight * 2/3).floor();
      _waterML = (_waterOZ * 29.57353).floor();
      _visualOZ = _waterOZ;
      _visualML = _waterML;

    }else{
      _isPound = isPound;
      _waterOZ = ((weight*2.20462) * 2/3).floor();
      _waterML = (_waterOZ * 29.57353).floor();
      _visualOZ = _waterOZ;
      _visualML = _waterML;
    }
  }
  void setDays(List<String> days, String level_of_fitness) {
    _days = days;
    for (String d in _days) {
      if (weekday == map[d]) {
        if (level_of_fitness == 'Low') {
          _waterOZ += 20;
          _waterML += (20 * 29.57353).floor();


      } else if (level_of_fitness == 'Moderate') {
        _waterOZ += 30;
        _waterML += (30 * 29.57353).floor();
      } else if (level_of_fitness == 'High') {
        _waterOZ += 40;
        _waterML += (40 * 29.57353).floor();
      }
     }
    }
    reset();
  }
}