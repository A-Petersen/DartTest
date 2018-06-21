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

  bool running = true; //Könnte man auch pause nennen
  bool initSucces = false; //Ob das Spiel bereits initalsiert wurde (erfolgreich)
  int highscore;

  bool loading = false;

  Controller(this.highscore) {
    field = new Field(this);
    startScreenButton();
    field.initStartScreen();
  }

  Future init() async {
    startButton();
    if (checkForOrientation()) {
      print(init);
      initSucces = true;
      field.initField();
      game = new Game(highscore, field.updateUFOs, field.removeUFO, field.createNewUFO);
      figureControll();
      resetButton();
      if (!loading) await setLevel();
      print(game.allLevels[0]);
      newGame();
    }
  }

  void newGame() {
    timerStart = new Timer.periodic(timeIntevall, (Timer t) => start());
    timerNewUFO = new Timer.periodic(throwIntevall, (Timer t) => checkUFOs());
    checkUFOs();
    start();
  }

  void checkUFOs() {
    if (running) {
      game.checkUFOs(timeMillis);
      field.setLevel(game.checkLevel());
    }
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void start() {
    if (checkForOrientation() && running) {
    game.checkUFOState(timeMillis);
    game.figure.move();
    field.updateFigure(game.figure);
    field.setAttempts(game.attempts);
    }
    if (game.gameover) {
            gameover();
            setHighscore(game.highscore);
        }
        field.setScore(game.score);
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
      running = true;
      loading = false;
      game.reset();
      field.reset();
      field.updateFigure(game.figure);
      init();
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
    return true;
  }

  Future setLevel() {
      List<Level> levels = new List();
      var request;
      try {
          request = HttpRequest.getString(levelconcept).then((json) {
          final parameter = JSON.decode(json);
          int levelAmount = parameter["LevelAmount"];
          for (int i = 1; i <= levelAmount; i++) {
            String level = "Level" + i.toString();
            levels.add(new Level(
                parameter[level]['Number'],
                parameter[level]['RequiredScore'],
                parameter[level]['FruitsAmount'],
                parameter[level]['BombChance'],
                parameter[level]['SmoothieChance'],
                parameter[level]['HeartChance'],
                parameter[level]['FruitRange'],
                parameter[level]['FruitMovement']));
          }
          game.setLevel(levels);
          loading = true;
        });
      } catch (error, stacktrace) {
        print ("SnakeGameController() caused following error: '$error'");
        print ("$stacktrace");
      }
      return request;

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

  int getGameSizeX() {
    return game.fixedFieldWidth;
  }

  int getGameSizeY() {
    return game.fixedFieldHeight;
  }

}




