import '../model/Fruit.dart';
import '../model/FruitFactory.dart';
import '../model/Game.dart';
import '../view/Field.dart';
import '../model/Figure.dart';
import '../model/Level.dart';
import 'dart:html';
import 'dart:async';
import 'dart:math';



class Controller {

  final Field field = new Field();


  List<Fruit> fruits = new List<Fruit>();
  Timer timerStart;
  Timer timerNewFruit;
  Figure frank;
  Game game = new Game();
  Level level = new Level();
  FruitFactory fruitFactory = new FruitFactory();


  Controller() {
    figureControll();
    timerStart = new Timer.periodic(new Duration(milliseconds: 50), (Timer t) => start());
    timerNewFruit = new Timer.periodic(new Duration(milliseconds: 2000), (Timer t) => checkFruits());
    frank = new Figure(0.0, 280.0, 100.0, 100.0, field);
  }

  void movement(Fruit f) {
    f.move();
    field.updateFruit(f);
  }

  void checkFruits() {

    if (game.fruits < level.maxFruits) {
      int type = level.possibleFruits == 1 ? 1 :  new Random().nextInt(level.possibleFruits)+1;
      print(type);
      newFruit(fruitFactory.newFruit(type, field));
    }

    if (game.score > 3 && game.score < 6) {
      level.level = 2;
      level.maxFruits = 4;
      level.possibleFruits = 2;
    }

    if (game.score > 10 && game.score < 30) {
      level.level = 3;
      level.maxFruits = 5;
      level.possibleFruits = 3;
    }
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {

    for (int i = 0 ; i < fruits.length ; i++) {
      if (fruits[i].moving) {
        movement(fruits[i]);
        querySelector("#output").text = fruits.length.toString();
        if ((fruits[i].y >= 260.0 && !frank.onDrum(fruits[i]))) {
          fruits[i].moving = false;
          removeFruit(fruits[i--]);
          if (--game.attempts <= -100) {
            gameover();
            return;
          }
        }
        if (fruits[i].y > field.height - (frank.b * 0.75) && frank.onDrum(fruits[i])) {
          fruits[i].goingUp = true;
        }

        if (fruits[i].left >= 480 && fruits[i].heaven >= 240) {
          fruits[i].moving = false;
          field.setScore(++game.score);
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
  Fruit newFruit(Fruit f) {
    fruits.add(f);
    field.createNewFruit(f);
    game.fruits++;
    return (f);
  }

  /**
   * Eine Fruit entfernen
   */
  void removeFruit(Fruit f) {
    fruits.remove(f);
    field.removeFruit(f);
    game.fruits--;
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
    timerStart.cancel();
  }



}

