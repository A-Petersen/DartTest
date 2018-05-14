import 'model/Fruit.dart';
import 'model/Field.dart';
import 'model/Figure.dart';
import 'dart:html';
import 'dart:async';

final field = new Field();
Figure frank = new Figure(0.0, 300.0, 50.0, 53.0, field);

class Controller {

  List<Fruit> fruits = new List<Fruit>();
  Timer fruitTimer;

  Controller() {
    figureControll();
    fruitTimer = new Timer.periodic(new Duration(milliseconds: 10), (Timer t) => start());
  }

  void movement(Fruit f, double richtung, Function curve) {
    double y = curve(f.x + richtung);
    querySelector("#output").text =  y.toString() + ' --- ' + f.x.toString() + ' --- ' + f.goingUp.toString() + ' --- ' + frank.onDrum(f).toString();
    f.move(richtung, y - f.y);
    field.updateFruit(f);
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {
    for (int i = 0 ; i < fruits.length ; i++) {
      if (fruits[i].moving) {
//        querySelector("#output").text = (1/(((fruits[i].x-80)*(fruits[i].x-80))*(1/5000))).toString() + ' ----- ' + fruits[i].x.toString();
//        movement(fruits[i], 1.0, ((x) => (1/(((x-100)*(x-100))*(1/100000)))));
        double upOrDown = fruits[i].goingUp ? -1.0 : 1.0;
        movement(fruits[i], 0.0, (x) => fruits[i].y + upOrDown);
        if ((fruits[i].y == 305.0 && !frank.onDrum(fruits[i]))) {
          fruits[i].moving = false;
        }
        if (fruits[i].y > 300.0 && frank.onDrum(fruits[i])) {
          fruits[i].goingUp = true;
        }

      } else {
        fruits.removeAt(i--);
      }
    }
  }

  double kurveFallend (double x) {
    return (1.0/(((x-100.0)*(x-100.0))*(1.0/100000.0)));
  }

  double kurveSteigend (double x) {
    return (1.0/(((x-100.0)*(x-100.0))*(1.0/100000.0)));
  }

  /**
   * Eine neue Fruit erstellen
   */
  Fruit newFruit(double x, double y, double radius) {
    fruits.add(new Fruit(x, y, radius, field));
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
        case KeyCode.LEFT : frank.move(-1.0); break;
        case KeyCode.RIGHT : frank.move(1.0); break;
      }
      field.updateFigure(frank);
    });
  }

}

