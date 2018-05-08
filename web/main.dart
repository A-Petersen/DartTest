import 'dart:html';
import 'dart:async';
import 'model/field.dart';
import 'model/fruit.dart';

final field = new Field();
Fruit fruit = new Fruit(field.center_X, field.center_y, field.size / 4, field);

void main() {

  const oneSec = const Duration(milliseconds: 10);
  new Timer.periodic(oneSec, (Timer t) => moveBall());

}

void moveBall() {
  fruit.move(0.5, 0.5);
  field.update(fruit);
}
