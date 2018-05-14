import 'model/Fruit.dart';
import 'model/Field.dart';
import 'model/Figure.dart';
import 'dart:html';
import 'dart:async';
final field = new Field();

class Controller {

  List<Fruit> fruits = new List<Fruit>();
  Figure frank = new Figure(0.0, 300.0, 50.0, 53.0, field);
  Timer fruitTimer;

  Controller() {
    figureControll();
    fruitTimer = new Timer.periodic(new Duration(milliseconds: 10), (Timer t) => start());
  }

  void movement(Fruit f, double richtung, Function curve) {
    double y = curve(x);
    f.move(x, y);
    field.updateFruit(f);
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {
    int i = 0;
    for (int i = 0 ; i < fruits.length ; i++) {
      if (fruits[i].moving) {
        movement(fruits[i], 1.0, ((x) => x*x/15));
      } else {
        fruits.removeAt(i--);
      }
    }

  }

  /**
   * Eine neue Fruit erstellen
   */
  Fruit newFruit(double x, double y, double radius) {
    fruits.add(new Fruit(x, y, radius, field));
    querySelector("#output").text = fruits.length.toString();
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

