import '../utils/tabletomap.dart';

class SearchResults {
  List _results;
  
  SearchResults(String html) {
    _results = [];
    var raw = parseTables(html)[0];
    for (var i = 0; i < raw.length; i++) {
      var cleanSubj = {};
      cleanSubj['code'] = raw[i]['CODE'];
      cleanSubj['name'] = raw[i]['SUBJECT'];
      cleanSubj['description'] = raw[i]['DESCRIPTION'];
      cleanSubj['schedule'] = raw[i]['SCHEDULE'];
      cleanSubj['division'] = raw[i]['DIVISION'];
      cleanSubj['availableSlots'] = int.parse(raw[i]['A']);
      cleanSubj['totalSlots'] = int.parse(raw[i]['S']);
      cleanSubj['reservedSlots'] = int.parse(raw[i]['R']);
      cleanSubj['enrolledSlots'] = int.parse(raw[i]['E']);
      cleanSubj['teacher'] = raw[i]['TEACHER'];

      _results.add(cleanSubj);
    }
  }

  Map find(Map object) {
    var keysToFind = object.keys;
    for (var i = 0; i < _results.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_results[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        return _results[i];
      }
    }
    return null;
  }

  List<Map> filter(Map object) {
    var foundObjects = [];
    var keysToFind = object.keys;
    for (var i = 0; i < _results.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_results[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        foundObjects.add(_results[i]);
      }
    }
    return foundObjects;
  }

  List all() {
    return _results;
  }
}