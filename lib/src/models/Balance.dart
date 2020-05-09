import '../utils/tabletomap.dart';

class Balance {
  List _balance;
  
  Balance(List htmlArray) {
    _balance = [];
    for (var i = 0; i < htmlArray.length; i++) {
      var newBalance = {};
      var raw = parseTables(htmlArray[i]);
      Map accountTable = raw[0][1];

      newBalance['academicPeriod'] = accountTable[accountTable.keys.elementAt(3)];
      newBalance['rgcNumber'] = accountTable[accountTable.keys.elementAt(1)];
      newBalance['tuitionFee'] = double.parse(raw[1][1]['DUE AMOUNT']);
      newBalance['totalWithOldFee'] = double.parse(raw[1][1]['BALANCE  (OVERPAYMENT)']);
      newBalance['miscLab'] = double.parse(raw[1][2]['DUE AMOUNT']);
      newBalance['scholarship'] = double.parse(raw[1][2]['BALANCE  (OVERPAYMENT)']);
      newBalance['totalCurrent'] = double.parse(raw[1][3]['DUE AMOUNT']);
      newBalance['totalAdjustment'] = double.parse(raw[1][3]['BALANCE  (OVERPAYMENT)']);
      newBalance['oldAccount'] = double.parse(raw[1][4]['DUE AMOUNT']);
      newBalance['totalDue'] = double.parse(raw[1][4]['BALANCE  (OVERPAYMENT)']);
      newBalance['amountPaid'] = double.parse(raw[1][5]['PAYMENTS']);
      newBalance['balance'] = double.parse(raw[1][6]['PAYMENTS']);
      newBalance['terms'] = {
        'downpayment': {
          'dueAmount': double.parse(raw[1][7]['DUE AMOUNT']),
          'payments': double.parse(raw[1][7]['PAYMENTS']),
          'balance': double.parse(raw[1][7]['BALANCE  (OVERPAYMENT)'])
        },
        'prelims': {
          'dueAmount': double.parse(raw[1][8]['DUE AMOUNT']),
          'payments': double.parse(raw[1][8]['PAYMENTS']),
          'balance': double.parse(raw[1][8]['BALANCE  (OVERPAYMENT)'])
        },
        'midterms': {
          'dueAmount': double.parse(raw[1][9]['DUE AMOUNT']),
          'payments': double.parse(raw[1][9]['PAYMENTS']),
          'balance': double.parse(raw[1][9]['BALANCE  (OVERPAYMENT)'])
        },
        'finals': {
          'dueAmount': double.parse(raw[1][10]['DUE AMOUNT']),
          'payments': double.parse(raw[1][10]['PAYMENTS']),
          'balance': double.parse(raw[1][10]['BALANCE  (OVERPAYMENT)'])
        }
      };
      _balance.add(newBalance);
    }
  }

  Map find(Map object) {
    var keysToFind = object.keys;
    for (var i = 0; i < _balance.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_balance[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        return _balance[i];
      }
    }
    return null;
  }

  List<Map> filter(Map object) {
    var foundObjects = [];
    var keysToFind = object.keys;
    for (var i = 0; i < _balance.length; i++) {
      var found = false;
      for (var j = 0; j < keysToFind.length; j++) {
        if (_balance[i][keysToFind.elementAt(j)] != object[keysToFind]) {
          found = false;
          break;
        }
        found = true;
      }
      if (found) {
        foundObjects.add(_balance[i]);
      }
    }
    return foundObjects;
  }

  List all() {
    return _balance;
  }
}