import 'model/Fruit.dart';
import 'model/Field.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';

final field = new Field();
Fruit fruit = new Fruit(field.center_x, field.center_y, field.size / 4, field);

void main() {

  const oneSec = const Duration(milliseconds: 10);
  new Timer.periodic(oneSec, (Timer t) => moveFruit());

}

void moveFruit() {
  fruit.move(0.5, 0.5);
  field.update(fruit);
}