import 'model/Fruit.dart';
import 'model/Field.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';

final field = new Field();
Fruit fruit = new Fruit(0.0, 50.0, 100.0, field);

void main() {

  const oneSec = const Duration(milliseconds: 10);
  new Timer.periodic(oneSec, (Timer t) => moveFruit());

}

void moveFruit() {
  fruit.move(0.5, 0.5);
  field.update(fruit);
}