import '../model/Fruit.dart';
import '../view/Field.dart';
import '../model/Figure.dart';
import 'dart:html';
import 'dart:async';



class Controller {

  List<Fruit> fruits = new List<Fruit>();
  Timer timer;
  final Field field = new Field();
  final fieldQuery = querySelector('#field');
  Figure frank;
  int score = 0;
  int attempts = 3;

  Controller() {
    figureControll();
    timer = new Timer.periodic(new Duration(milliseconds: 50), (Timer t) => start());
    frank = new Figure(0.0, 280.0, 100.0, 100.0, field);
  }

  void movement(Fruit f, double richtung, Function curve) {
    double hoeheProzent = ( f.y <= 1 ? 0.95 : (f.y / 320) ); // 0.x
    double y = curve(hoeheProzent);
    f.move(richtung, y);
    field.updateFruit(f);
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {
    for (int i = 0 ; i < fruits.length ; i++) {
      if (fruits[i].moving) {
        double upOrDown = fruits[i].goingUp ? (-1)*fruits[i].gravity : fruits[i].gravity;
        movement(fruits[i], fruits[i].speed, (x) => upOrDown * x);
        querySelector("#output").text = fruits.length.toString();
        if ((fruits[i].y >= 260.0 && !frank.onDrum(fruits[i]))) {
          fruits[i].moving = false;
          removeFruit(fruits[i--]);
          if (--attempts <= 0) {
            gameover();
            return;
          }
        }
        if (fruits[i].y > field.height - (frank.b * 0.75) && frank.onDrum(fruits[i])) {
          fruits[i].goingUp = true;
        }

        if (fruits[i].left >= 480 && fruits[i].heaven >= 240) {
          fruits[i].moving = false;
          field.setScore(++score);
        }

      } else {
        removeFruit(fruits[i--]);
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

  /**
   * Eine neue Fruit erstellen
   */
  Fruit newFruit(double x, double y, double radius, [double gravity = 10.0, double speed = 1.0]) {
    Fruit f = new Fruit(x, y, radius, field, gravity, speed);
    fruits.add(f);
    var fruitDiv = new DivElement();
    fruitDiv.id = 'fruit' + Fruit.id.toString();
    fieldQuery.children.add(fruitDiv);
    field.fruits.putIfAbsent(fruit, fruitDiv);
    return (f);
  }

  /**
   * Eine Fruit entfernen
   */
  void removeFruit(Fruit f) {
    fruits.remove(f);
    field.fruits.remove(f);
  }

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

  void gameover() {
    timer.cancel();
  }



}

