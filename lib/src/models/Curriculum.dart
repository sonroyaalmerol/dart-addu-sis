import '../utils/tabletomap.dart';

class Curriculum {
  List _curriculum;
  
  Curriculum(String html) {
    _curriculum = [];
    var raw = parseTables(html)[0];
    for (var i = 0; i < raw.length; i++) {
      var cleanSubj = {};
      cleanSubj['yearLevel'] = raw[i]['YEAR LEVEL'];
      cleanSubj['semester'] = raw[i]['SEMESTER'];
      cleanSubj['name'] = raw[i]['SUBJ. NO'];
      cleanSubj['description'] = raw[i]['DESCRIPTIVE TITLE'];
      cleanSubj['grade'] = raw[i]['GRADE'];
      cleanSubj['units'] = raw[i]['UNITS'];
      cleanSubj['remarks'] = raw[i]['REMARKS'];
      cleanSubj['prerequisites'] = raw[i]['PREREQUISITE'];

      _curriculum.add(cleanSubj);
    }
  }

  Map find(Map object) {
    var keysToFind = object.keys;
    for (var i = 0; i < _curriculum.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_curriculum[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        return _curriculum[i];
      }
    }
    return null;
  }

  List<Map> filter(Map object) {
    var foundObjects = [];
    var keysToFind = object.keys;
    for (var i = 0; i < _curriculum.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_curriculum[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        foundObjects.add(_curriculum[i]);
      }
    }
    return foundObjects;
  }

  List all() {
    return _curriculum;
  }
}