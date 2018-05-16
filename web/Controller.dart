import 'model/Fruit.dart';
import 'model/Field.dart';
import 'model/Figure.dart';
import 'dart:html';
import 'dart:async';

final field = new Field();
final fieldQuery = querySelector('#field');

Figure frank = new Figure(0.0, 280.0, 100.0, 100.0, field);

class Controller {

  List<Fruit> fruits = new List<Fruit>();
  Timer fruitTimer;

  Controller() {
    figureControll();
    fruitTimer = new Timer.periodic(new Duration(milliseconds: 50), (Timer t) => start());
  }

  void movement(Fruit f, double richtung, Function curve) {
    double hoeheProzent = ( f.y <= 1 ? 0.95 : (f.y / 320) ); // 0.x
    double y = curve(hoeheProzent);
    querySelector("#output").text =  'x: ' + f.x.toString() + ' --- onDrum: ' + frank.onDrum(f).toString() + ' --- goingUp: ' + f.goingUp.toString() + ' --- yREAL:' + f.y.toString() + ' --- y: ' + y.toString() + ' --- Fmove:' + frank.moving.toString();
    f.move(richtung, y);
    field.updateFruit(f);
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {
    for (int i = 0 ; i < fruits.length ; i++) {
      if (fruits[i].moving) {
//        querySelector("#output").text = (1/(((fruits[i].x-80)*(fruits[i].x-80))*(1/5000))).toString() + ' ----- ' + fruits[i].x.toString();
        double upOrDown = fruits[i].goingUp ? (-1)*fruits[i].gravity : fruits[i].gravity;
        movement(fruits[i], fruits[i].speed, (x) => upOrDown * x);
        if ((fruits[i].y == 305.0 && !frank.onDrum(fruits[i]))) {
          fruits[i].moving = false;
        }
        if (fruits[i].y > field.height - (frank.b * 0.75) && frank.onDrum(fruits[i])) {
          fruits[i].goingUp = true;
        }

      } else {
        fruits.removeAt(i--);
      }
    }
    switch (frank.moving) {
      case (1):
        frank.move(frank.speed);
        break;
      case (2):
        frank.move((-1) * frank.speed);
        break;
      case (0):
        frank.move(0.0);
        break;
    }
    field.updateFigure(frank);

  }

//  double kurveFallend (double x) {
//    return (1.0/(((x-100.0)*(x-100.0))*(1.0/100000.0)));
//  }
//
//  double kurveSteigend (double x) {
//    return (1.0/(((x-100.0)*(x-100.0))*(1.0/100000.0)));
//  }

  /**
   * Eine neue Fruit erstellen
   */
  Fruit newFruit(double x, double y, double radius, [double gravity = 10.0, double speed = 1.0]) {
    fruits.add(new Fruit(x, y, radius, field, gravity, speed));
    var fruitDiv = new DivElement();
    fruitDiv.id = 'fruit' + Fruit.id.toString();
    fieldQuery.children.add(fruitDiv);
    return (fruits[fruits.length-1]);
  }

  /**
   * Eine Fruit entfernen
   */
  void removeFruit(Fruit f) {
    fruits.remove(f);
  }

  /*double absoluteValue(double d) {
    return d > 0 ? d : -d;
  }*/

  /**
   * Bewegungen für die Spielfigur Frank einstellen
   */
  void figureControll() {
    window.onKeyDown.listen((KeyboardEvent ev) {
      switch (ev.keyCode) {
        case KeyCode.LEFT :
          frank.moving = 2;
          break;
        case KeyCode.RIGHT :
          frank.moving = 1;
          break;
      }
//      if (frank.moveRight) frank.move(frank.speed);
//      if (!frank.moveRight) frank.move((-1)*frank.speed);
//      field.updateFigure(frank);
    });
    window.onKeyUp.listen((KeyboardEvent ev) {
      switch (ev.keyCode) {
        case KeyCode.LEFT :
          if (frank.moving != 1) frank.moving = 0;
          break;
        case KeyCode.RIGHT :
          if (frank.moving != 2) frank.moving = 0;
          break;
      }
    });
  }

}

