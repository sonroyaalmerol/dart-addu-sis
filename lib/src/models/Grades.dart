import '../utils/tabletomap.dart';

class Grades {
  List _grades;
  
  Grades(List htmlArray) {
    _grades = [];
    for (var i = 0; i < htmlArray.length; i++) {
      var newGrades = {
        'subjects': [],
        'qpi': ''
      };
      var raw = parseTables(htmlArray[i]);
      Map accountTable = raw[0][1];
      newGrades['academicPeriod'] = accountTable[accountTable.keys.elementAt(3)];
      newGrades['qpi'] = raw[1][raw[1].length-1]['FINAL'];
      var subjects = [];
      for (var i = 0; i < (raw.length - 1); i++) {
        var cleanGrades = {};
        cleanGrades['code'] = raw[1][i]['SUBJ NO.'].split(' (')[1].replaceAll(')', '');
        cleanGrades['name'] = raw[1][i]['SUBJ NO.'].split(' (')[0];
        cleanGrades['description'] = raw[1][i]['DESCRIPTIVE TITLE'].split(' (* ')[0];
        cleanGrades['schedule'] = raw[1][i]['DESCRIPTIVE TITLE'].split(' (* ')[1].replaceAll(' * )', '');
        cleanGrades['prelimGrade'] = raw[1][i]['PRELIM'];
        cleanGrades['midtermGrade'] = raw[1][i]['MIDTERM'];
        cleanGrades['prefinalGrade'] = raw[1][i]['PRE-FINAL'];
        cleanGrades['finalGrade'] = raw[1][i]['FINAL'];
        cleanGrades['units'] = raw[1][i]['UNITS'];

        subjects.add(cleanGrades);
      }
      newGrades['subjects'] = subjects;
      _grades.add(newGrades);
    }
  }

  Map find(Map object) {
    var keysToFind = object.keys;
    for (var i = 0; i < _grades.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_grades[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        return _grades[i];
      }
    }
    return null;
  }

  List<Map> filter(Map object) {
    var foundObjects = [];
    var keysToFind = object.keys;
    for (var i = 0; i < _grades.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_grades[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        foundObjects.add(_grades[i]);
      }
    }
    return foundObjects;
  }

  List all() {
    return _grades;
  }
}