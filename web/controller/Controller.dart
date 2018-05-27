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
  Timer timerStart;
  Timer timerNewFruit;
  Figure frank;
  Game game;



  Controller() {
    figureControll();
    game = new Game(field, this);
    timerStart = new Timer.periodic(new Duration(milliseconds: 50), (Timer t) => start());
    timerNewFruit = new Timer.periodic(new Duration(milliseconds: 2000), (Timer t) => checkFruits());
    frank = new Figure(0.0, 280.0, 100.0, 100.0, field);
  }

  void movement(Fruit f) {
    f.move();
    field.updateFruit(f);
  }

  void checkFruits() {
    game.checkFruits();
    game.checkLevel();
  }


  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {

    for (int i = 0 ; i < game.fruits ; i++) {
      if (game.fruitsList[i].moving) {
        movement(game.fruitsList[i]);
        if ((game.fruitsList[i].y >= 260.0 && !frank.onDrum(game.fruitsList[i]))) {
          game.fruitsList[i].moving = false;
          removeFruit(game.fruitsList[i--]);
          if (--game.attempts <= -100) {
            gameover();
            return;
          }
        }
        if (game.fruitsList[i].y > field.height - (frank.b * 0.75) && frank.onDrum(game.fruitsList[i])) {
          game.fruitsList[i].goingUp = true;
        }

        if (game.fruitsList[i].left >= 480 && game.fruitsList[i].heaven >= 240) {
          game.fruitsList[i].moving = false;
          field.setScore(++game.score);
        }

      } else {
        game.removeFruit(game.fruitsList[i--]);
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
    field.createNewFruit(f);
  }

  /**
   * Eine Fruit entfernen
   */
  void removeFruit(Fruit f) {
    field.removeFruit(f);
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

