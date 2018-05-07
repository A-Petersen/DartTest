import 'dart:html';
import 'dart:async';
import 'dart:math';

class Field {
  TableRowElement row;
  TableCellElement cell;
  int rowValue;
  int cellValue;

  Field(TableRowElement row, TableCellElement cell, int rowValue, cellValue) {
    this.row = row;
    this.cell = cell;
    this.rowValue = rowValue;
    this.cellValue = cellValue;
  }

  TableCellElement get getCell => cell;


}

List tableFields = new List();

void main() {

  TableElement table = document.getElementById("table");
  tableFields = new List();

  for (int i = 0 ; i < 8 ; i++) {
    TableRowElement row = table.addRow();
    for (int j = 0 ; j < 8 ; j++) {
      TableCellElement cell = row.addCell();
      cell.text = (j).toString();
      tableFields.add(new Field(row, cell, i, j));
    }
  }

  const oneSec = const Duration(milliseconds: 1);
  new Timer.periodic(oneSec, (Timer t) => doSomething());

}

void doSomething() {
  for (int i = 0 ; i < tableFields.length ; i++) {
    var rng = new Random();
    Field field = tableFields[i];
    field.getCell.text = rng.nextInt(10).toString();
  }
}
