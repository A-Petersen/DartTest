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

  bool running = false; //Könnte man auch pause nennen
  bool initSucces = false; //Ob das Spiel bereits initalsiert wurde (erfolgreich)
  int highscore;

  Controller(this.highscore) {
    init();
  }

  void init() {
    field = new Field(this);
    startButton();
    if (checkForOrientation()) {
      initSucces = true;
      field.init();
      game = new Game(this, field.width, field.height, highscore);
      figureControll();
      resetButton();
      newGame();
    }
  }

  void newGame() {
    timerStart = new Timer.periodic(timeIntevall, (Timer t) => start());
    timerNewUFO = new Timer.periodic(throwIntevall, (Timer t) => checkUFOs());
    checkUFOs();
  }

  void checkUFOs() {
    checkForOrientation();
    if (running) {
      game.checkUFOs();
      game.checkLevel();
    }
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {
    print(game.score);
    print(game.fruits);
    checkForOrientation();
    if (running) {
    game.checkUFOState();
    game.figure.move();
    field.updateFigure(game.figure);
    }
  }

  /**
   * Eine neues UFO erstellen
   */
  void newUFOView(AbstractUFO ufo) {
    field.createNewUFO(ufo);
  }

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
      initSucces = false;
      running = false;
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
    highscore = score;
    window.localStorage["score"] = score.toString();
  }

  int getHighscore() { return game.highscore; }

  bool checkForOrientation() {
    if(window.innerHeight > window.innerWidth){
      field.showOrientationInfo();
      running = false;
      return false;
    }
    running = true;
    return true;
  }


  void startButton() {
    field.startButton.onClick.listen((MouseEvent ev) {
      running  = true;
      field.hideOrientationInfo();
      if (!initSucces) {
        init();
      }
    });
  }

}

