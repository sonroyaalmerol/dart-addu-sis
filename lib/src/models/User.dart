import '../utils/tabletomap.dart';

class User {
  String card, id, name, course, section, division, year, status;

  User(String html) {
    var raw = parseTables(html)[0];
    card = raw[0].keys.elementAt(1);
    id = raw[0][raw[0].keys.elementAt(1)];
    name = raw[1][raw[1].keys.elementAt(1)];
    course = raw[0].keys.elementAt(3);
    section = raw[0][raw[0].keys.elementAt(3)];
    division = raw[1][raw[1].keys.elementAt(3)];
    year = raw[1].keys.elementAt(5);
    status = raw[1][raw[1].keys.elementAt(5)];
  }

  Map all() {
    return {
      'card': card,
      'id': id,
      'name': name,
      'course': course,
      'section': section,
      'division': division,
      'year': year,
      'status': status
    };
  }
}