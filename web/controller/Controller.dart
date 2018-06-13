import '../model/FruitObject/AbstractUFO.dart';
import '../model/FruitObject/Fruit.dart';
import '../model/Game.dart';
import '../model/Level.dart';
import '../view/Field.dart';
import 'dart:convert';
import 'dart:html';
import 'dart:async';

const levelconcept = 'Levelkonzept.json';
var test;

class Controller {

  static int timeMillis = 30;
  static int throwMillis = 4000;
  
  Field field;
  Game game;
  Timer timerStart;
  Timer timerNewUFO;
  Duration timeIntevall = new Duration(milliseconds: timeMillis);
  Duration throwIntevall = new Duration(milliseconds: throwMillis);


  bool running = false; //Könnte man auch pause nennen
  bool initSucces = false; //Ob das Spiel bereits initalsiert wurde (erfolgreich)
  int highscore;

  bool loading = false;

  Controller(this.highscore) {
    field = new Field(this);
    startScreenButton();
    field.initStartScreen();
  }

  void init() {
    startButton();
    if (checkForOrientation()) {
      initSucces = true;
      field.initField();
      game = new Game(this, field.width, field.height, highscore);
      figureControll();
      resetButton();
      if (!loading) setLevel();
      newGame();
    }
  }

  void newGame() {
    timerStart = new Timer.periodic(timeIntevall, (Timer t) => start());
    timerNewUFO = new Timer.periodic(throwIntevall, (Timer t) => checkUFOs());
  }

  void checkUFOs() {
    checkForOrientation();
    if (running) {
      game.checkUFOs(timeMillis);
      field.setLevel(game.checkLevel());
    }
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {
    checkForOrientation();
    if (running) {
    game.checkUFOState(timeMillis);
    game.figure.move();
    field.updateFigure(game.figure);
    }
    if (game.gameover) {
            gameover();
            setHighscore(game.highscore);
        }
        field.setScore(game.score);
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

  void setLevel() {
      List<Level> levels = new List();
      var request;
      try {
          request = HttpRequest.getString(levelconcept).then((json) {
          final parameter = JSON.decode(json);
          int levelAmount = int.parse(parameter["LevelAmount"]);
          for (int i = 1; i <= levelAmount; i++) {
            String level = "Level" + i.toString();
            levels.add(new Level(
                int.parse(parameter[level]['Number']),
                int.parse(parameter[level]['RequiredScore']),
                int.parse(parameter[level]['FruitsAmount']),
                int.parse(parameter[level]['BombChance']),
                int.parse(parameter[level]['SmoothieChance']),
                int.parse(parameter[level]['FruitRange']),
                int.parse(parameter[level]['FruitMovement'])));
          }
          game.setLevel(levels);
          loading = true;
        });
      } catch (error, stacktrace) {
        print ("SnakeGameController() caused following error: '$error'");
        print ("$stacktrace");
      }
//      game.setLevel(levels);
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

  void startScreenButton() {
    field.startButtonStartScreen.onClick.listen((MouseEvent ev) {
      field.removeStartScreen();
      init();
    });
  }

}




