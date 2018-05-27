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
//  Figure frank;
  Game game;



  Controller() {
    figureControll();
    game = new Game(field, this);
    timerStart = new Timer.periodic(new Duration(milliseconds: 50), (Timer t) => start());
    timerNewFruit = new Timer.periodic(new Duration(milliseconds: 2000), (Timer t) => checkFruits());
//    frank = new Figure(0.0, 280.0, 100.0, 100.0, field);
  }

//  void movement(Fruit fruit) {
//    fruit.move();
//    field.updateFruit(fruit);
//  }

  void checkFruits() {
    game.checkFruits();
    game.checkLevel();
  }


  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {

//    for (int i = 0 ; i < game.fruits ; i++) {
//      if (game.fruitsList[i].moving) {
//        movement(game.fruitsList[i]);
//        if ((game.fruitsList[i].y >= 260.0 && !frank.onDrum(game.fruitsList[i]))) {
//          game.fruitsList[i].moving = false;
//          removeFruitView(game.fruitsList[i--]);
//          if (--game.attempts <= -100) {
//            gameover();
//            return;
//          }
//        }
//        if (game.fruitsList[i].y > field.height - (frank.b * 0.75) && frank.onDrum(game.fruitsList[i])) {
//          game.fruitsList[i].goingUp = true;
//        }
//
//        if (game.fruitsList[i].left >= 480 && game.fruitsList[i].heaven >= 240) {
//          game.fruitsList[i].moving = false;
//          field.setScore(++game.score);
//        }
//
//      } else {
//        game.removeFruit(game.fruitsList[i--]);
//      }
//    }

    game.checkFruitState();
    game.figure.move();
    field.updateFigure(game.figure);

  }

  /**
   * Eine neue Fruit erstellen
   */
  void newFruitView(Fruit fruit) {
    field.createNewFruit(fruit);
  }

  /**
   * Eine Fruit entfernen
   */
  void removeFruitView(Fruit fruit) {
    field.removeFruit(fruit);
  }

  /**
   * Bewegungen für die Spielfigur Frank einstellen
   */
  void figureControll() {
    window.onKeyDown.listen((KeyboardEvent ev) {
      switch (ev.keyCode) {
        case KeyCode.LEFT :
          game.figure.moving = 2;
          break;
        case KeyCode.RIGHT :
          game.figure.moving = 1;
          break;
      }

    });
    window.onKeyUp.listen((KeyboardEvent ev) {
      switch (ev.keyCode) {
        case KeyCode.LEFT :
          if (game.figure.moving != 1) game.figure.moving = 0;
          break;
        case KeyCode.RIGHT :
          if (game.figure.moving != 2) game.figure.moving = 0;
          break;
      }
    });
  }

  void gameover() {
    timerStart.cancel();
  }



}

