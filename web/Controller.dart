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
    fruitTimer = new Timer.periodic(new Duration(milliseconds: 30), (Timer t) => start());
  }

  /**
   * Das Objekt bekommt eine Bewegung mitgegeben.
   * dx = wie weit soll sich die Fruit sich bewegen.
   * dy = wie hoch soll die Fruit sich bewegen.
   */
  void setMovement(Fruit f, double dx, double dy) {
    //Zuerst wird das Verhältnis von dx und dy berechnet, so dass die Fruit sich in einer Art Bogen bewegen kann.
    double x = dx;
    double y = dy;
    x = dx/absoluteValue(dy);
    y = dy < 0.0 ? -1.0 : 1.0;

    //Dann wird geprüft, ob die Fruit sich nach oben oder nach unten bewegen muss.
    if (f.rangeX < dx/2) {
      f.move(x, y);
      f.rangeX = dx < 0 ? f.rangeX - x : f.rangeX + x;
      f.rangeY= dy < 0 ? f.rangeY - y : f.rangeY + y;
    } else {
      f.move(x, -y);
      f.rangeX = dx < 0 ? f.rangeX - x : f.rangeX + x;
      f.rangeY= dy < 0 ? f.rangeY - y : f.rangeY + y;
    }

    //Wurde die Bewegung abgeschlossen, soll sie von vorne beginnen.
    if (dx <= f.rangeX) {
      f.rangeX = 0.0;
      f.rangeY = 0.0;
      if (!frank.onDrum(f)) {
        f.moving = false;
      }
    }
    field.updateFruit(f);
    if (f.x == window.screen.width) {
      f.moving = false;
    }
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {
    int i = 0;
    for (int i = 0 ; i < fruits.length ; i++) {
      if (fruits[i].moving) {
        setMovement(fruits[i], 100.0, -200.0);
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

  double absoluteValue(double d) {
    return d > 0 ? d : -d;
  }

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

