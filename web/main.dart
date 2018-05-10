import 'model/Fruit.dart';
import 'model/Field.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';

final field = new Field();
Fruit fruit = new Fruit(0.0, 100.0, 25.0, field);

void main() {

  const oneSec = const Duration(milliseconds: 10);
  //Timer timer = new Timer.periodic(oneSec, (Timer t) => fruit.setMovement(1.0, 2.0));
  fruit.start(10, 50.0, 200.0);

}

