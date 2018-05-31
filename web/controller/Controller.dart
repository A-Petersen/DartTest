import '../model/Fruit.dart';
import '../model/Game.dart';
import '../view/Field.dart';
import 'dart:html';
import 'dart:async';



class Controller {

  Field field;
  Game game;
  Timer timerStart;
  Timer timerNewFruit;
  Duration timeIntevall = new Duration(milliseconds: 30);
  Duration throwIntevall = new Duration(milliseconds: 5000);

  Controller(int highscore) {
    field = new Field(this);
    game = new Game(this, field.width, field.height, highscore);
    figureControll();
    resetButton();
    newGame();
  }

  void newGame() {
    timerStart = new Timer.periodic(timeIntevall, (Timer t) => start());
    timerNewFruit = new Timer.periodic(throwIntevall, (Timer t) => checkFruits());
//    field.createTreesAndBasket();
    checkFruits();
  }


  void checkFruits() {
    game.checkFruits();
    game.checkLevel();
  }


  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {
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

    field.leftSite.onTouchStart.listen((TouchEvent ev) {
        game.figure.moving = 2;
    });

    field.leftSite.onTouchEnd.listen((TouchEvent ev) {
        if (game.figure.moving != 1) game.figure.moving = 0;
    });

    field.rightSite.onTouchStart.listen((TouchEvent ev) {
      game.figure.moving = 1;
    });

    field.rightSite.onTouchEnd.listen((TouchEvent ev) {
      if (game.figure.moving != 2) game.figure.moving = 0;
    });

  }
  
  void resetButton(){
    field.resetButton.onClick.listen((MouseEvent ev) {
      game.reset();
      field.reset();
      field.updateFigure(game.figure);
      newGame();
    });
  }

  void gameover() {
    timerStart.cancel();
    timerNewFruit.cancel();
    field.gameover();
  }

  void setHighscore(int score) {
    window.localStorage["score"] = score.toString();
  }

  int getHighscore() { return game.highscore; }



}

