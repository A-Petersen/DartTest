import 'model/Fruit.dart';
import 'model/Field.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';

final field = new Field();
Fruit fruit = new Fruit(field.center_x, field.center_y, field.size / 4, field);

void main() {

  const oneSec = const Duration(milliseconds: 10);
  new Timer.periodic(oneSec, (Timer t) => moveBall());

}

void moveBall() {
  double x = fruit.x;
  x+= x+1;
  double y = (-x^2) + 0.5;
  fruit.move(x, y);
  container.update(fruit);
}