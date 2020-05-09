import '../utils/tabletomap.dart';

class Registration {
  List _registration;
  
  Registration(String html) {
    _registration = [];
    var raw = parseTables(html)[1];
    for (var i = 0; i < raw.length; i++) {
      var cleanSubj = {};
      cleanSubj['code'] = raw[i]['CODE'];
      cleanSubj['number'] = raw[i]['SUBJ. NO'];
      cleanSubj['schedule'] = raw[i]['SCHEDULE'];
      cleanSubj['description'] = raw[i]['DESCRIPTIVE TITLE'];
      cleanSubj['units'] = raw[i]['UNIT'];

      _registration.add(cleanSubj);
    }
    print(_registration);
  }

  Map find(Map object) {
    var keysToFind = object.keys;
    for (var i = 0; i < _registration.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_registration[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        return _registration[i];
      }
    }
    return null;
  }

  List<Map> filter(Map object) {
    var foundObjects = [];
    var keysToFind = object.keys;
    for (var i = 0; i < _registration.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_registration[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        foundObjects.add(_registration[i]);
      }
    }
    return foundObjects;
  }

  List all() {
    return _registration;
  }
}