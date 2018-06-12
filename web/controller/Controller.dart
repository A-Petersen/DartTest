import '../model/FruitObject/AbstractUFO.dart';
import '../model/FruitObject/Fruit.dart';
import '../model/Game.dart';
import '../view/Field.dart';
import 'dart:html';
import 'dart:async';



class Controller {

  Field field;
  Game game;
  Timer timerStart;
  Timer timerNewUFO;
  Duration timeIntevall = new Duration(milliseconds: 30);
  Duration throwIntevall = new Duration(milliseconds: 5000);

  Controller(int highscore) {
    field = new Field(this);
    if (checkForOrientation()) {
      field.orientationInfo.remove();
      game = new Game(this, field.width, field.height, highscore);
      figureControll();
      resetButton();
      newGame();
    }
  }

  void newGame() {
    timerStart = new Timer.periodic(timeIntevall, (Timer t) => start());
    timerNewUFO = new Timer.periodic(throwIntevall, (Timer t) => checkUFOs());
//    timerNewUFO = new Timer.periodic(throwIntevall, (Timer t) => checkFruits());
//    checkFruits();
  checkUFOs();
  }


//  void checkFruits() {
//    game.checkUFOs();
//    game.checkFruits();
//    game.checkLevel();
//  }

  void checkUFOs() {
    game.checkUFOs();
    game.checkLevel();
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {

//    game.checkFruitState();
    game.checkUFOState();
    game.figure.move();
    field.updateFigure(game.figure);

    if (game.gameover) {
      gameover();
      setHighscore(game.highscore);
    }
    field.setScore(game.score);
  }

//  /**
//   * Eine neue Fruit erstellen
//   */
//  void newFruitView(Fruit fruit) {
//    field.createNewFruit(fruit);
//  }

  /**
   * Eine neues UFO erstellen
   */
  void newUFOView(AbstractUFO ufo) {
    field.createNewUFO(ufo);
  }

//  /**
//   * Eine Fruit entfernen
//   */
//  void removeFruitView(Fruit fruit) {
//    field.removeFruit(fruit);
//  }

  /**
   * Ein UFO entfernen
   */
  void removeUFOView(AbstractUFO ufo) {
    field.removeUFO(ufo);
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
    timerNewUFO.cancel();
    field.gameover();
  }

  void setHighscore(int score) {
    window.localStorage["score"] = score.toString();
  }

  int getHighscore() { return game.highscore; }

  bool checkForOrientation() {
    if(window.innerHeight > window.innerWidth){
      field.showOrientationInfo();
      return false;
    }
    return true;
  }



}

