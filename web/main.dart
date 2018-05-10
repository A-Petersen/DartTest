import 'model/Fruit.dart';
import 'model/Field.dart';
import 'model/Figure.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';

final field = new Field();
Fruit fruit = new Fruit(0.0, 300.0, 10.0, field);
Figure frank = new Figure(0.0, 300.0, field);

void main() {

  const oneSec = const Duration(milliseconds: 10);
  //Timer timer = new Timer.periodic(oneSec, (Timer t) => fruit.setMovement(1.0, 2.0));
  fruit.start(10, 50.0, -200.0);

  window.onKeyDown.listen((KeyboardEvent ev) {
      switch (ev.keyCode) {
        case KeyCode.LEFT : frank.move(-1.0); break;
        case KeyCode.RIGHT : frank.move(1.0); break;
      }
      field.updateFigure(frank);
  });



}

