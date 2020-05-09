import 'package:html/parser.dart' as parser; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';

List parseTables (String x) {
  var toReturn = [];
  var headers = [];
  var firstRowUsedAsHeaders = [];

  void _buildHeaders (int index, Element table) {
    headers[index] = [];

    var rows = table.getElementsByTagName('tr');
    for (var x = 0; x < rows.length; x++) {
      var row = rows[x];
      var headersList = row.getElementsByTagName('th');
      for (var y = 0; y < headersList.length; y++) {
        if (headers[index].length < y+1) {
          headers[index].add(null);
        }
        headers[index][y] = headersList[y].text.trim().replaceAll(RegExp(':'), '').replaceAll(RegExp(','), '');
      }
    }

    if (headers[index].isNotEmpty) return;

    firstRowUsedAsHeaders[index] = true;
    var firstRow = table.getElementsByTagName('tr').first.getElementsByTagName('td');
    for (var x = 0; x < firstRow.length; x++) {
      if (headers[index].length < x+1) {
        headers[index].add(null);
      }
      headers[index][x] = firstRow[x].text.trim().replaceAll(RegExp(':'), '').replaceAll(RegExp(','), '');
    }
  }

  void _processRow (int tableIndex, int index, Element row) {
    if (index == 0 && firstRowUsedAsHeaders[tableIndex] == true) return;
    toReturn[tableIndex][index] = {};
    var data = row.getElementsByTagName('td');
    for (var x = 0; x < data.length; x++) {
      var cell = data[x];
      toReturn[tableIndex][index][headers[tableIndex].length >= x+1 ? headers[tableIndex][x] : (x + 1).toString()] = cell.text.trim().replaceAll(RegExp(':'), '').replaceAll(RegExp(','), '');
    }
  }

  void _pruneEmptyRows (int tableIndex) {
    toReturn[tableIndex] = toReturn[tableIndex].where((t) => t.keys.isNotEmpty ? true : false).toList();
  }

  void _processTable (int tableIndex, Element table) {
    toReturn[tableIndex] = [];
    headers.add([]);
    firstRowUsedAsHeaders.add([]);
    _buildHeaders(tableIndex, table);

    var rows = table.getElementsByTagName('tr');
    for (var x = 0; x < rows.length; x++) {
      toReturn[tableIndex].add({});
      _processRow(tableIndex, x, rows[x]);
    }
    _pruneEmptyRows(tableIndex);
  }

  var document = parser.parse(x);
  var tables = document.getElementsByTagName('table');
  for (var x = 0; x < tables.length; x++) {
    toReturn.add([]);
    _processTable(x, tables[x]);
  }

  return toReturn;
}