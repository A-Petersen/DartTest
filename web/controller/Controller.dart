import '../model/Game.dart';
import '../model/Level.dart';
import '../model/Tutorial.dart';
import '../view/Field.dart';
import 'dart:convert';
import 'dart:html';
import 'dart:async';

const levelconceptAndTutorial = 'Levelkonzept&Tutorial.json';

class Controller {

  Field field;
  Game game;
  Timer timerRun;
  Timer timerCheckUFO;
  Duration runIntervall = new Duration(milliseconds: 30);
  Duration checkUFOIntervall = new Duration(milliseconds: 4000);

  bool running = true; //Könnte man auch pause nennen
  bool initSucces = false; //Ob das Spiel bereits initalsiert wurde (erfolgreich)
  int highscore;

  bool loading = false;

  bool tutorialOn = true;

  Controller(this.highscore) {
    field = new Field(this);
    startScreenButtonsListener();
    tutorialButtonListener();
    field.initStartScreen();
  }

  Future init() async {
    orientationInfoStartButtonListener();
    if (checkForOrientation()) {
      initSucces = true;
      field.initField();
      game = new Game(highscore, field.updateUFOs, field.removeUFO, field.createNewUFO, tutorial);
      touchListener();
      resetButtonListener();
      if (!loading) await setLevel();
      newGame();
    }
  }

  void newGame() {
    timerRun = new Timer.periodic(runIntervall, (Timer t) => run());
    timerCheckUFO = new Timer.periodic(checkUFOIntervall, (Timer t) => checkUFOs());
    checkUFOs();
    run();
  }

  void checkUFOs() {
    if (running) {
      game.checkUFOs();
      field.setLevel(game.checkLevel());
    }
  }

  /**
   * Die Fruit wird gestartet, bzw. geworfen.
   */
  void run() {
    if (checkForOrientation() && running) {
    game.checkUFOState(runIntervall.inMilliseconds);
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
  void touchListener() {
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
  
  void resetButtonListener(){
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
    timerRun.cancel();
    timerCheckUFO.cancel();
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
          request = HttpRequest.getString(levelconceptAndTutorial).then((json) {
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
                parameter[level]['FruitMovement'])
            );
          }
          game.setLevels(levels);
          game.setTutorial(new Tutorial(
              parameter['Tutorial']['Banane'],
              parameter['Tutorial']['Movement'],
              parameter['Tutorial']['Bomb'],
              parameter['Tutorial']['Heart'],
              parameter['Tutorial']['Smoothie'])
          );
          loading = true;
        });
      } catch (error, stacktrace) {
        print ("SnakeGameController() caused following error: '$error'");
        print ("$stacktrace");
      }
      return request;

  }

  void orientationInfoStartButtonListener() {
    field.orientationInfoStartButton.onClick.listen((MouseEvent ev) {
      running  = true;
      field.hideOrientationInfo();
      if (!initSucces) {
        init();
      }
    });
  }

  void startScreenButtonsListener() {
    field.startButtonStartScreen.onClick.listen((MouseEvent ev) {
      field.removeStartScreen();
      init();
    });
    field.tutorialButtonStartScreen.onClick.listen((MouseEvent ev) {
      if (tutorialOn) {
        tutorialOn = false;
        field.tutorialButtonStartScreen.text = "Tutorial: Off";
      } else {
        tutorialOn = true;
        field.tutorialButtonStartScreen.text = "Tutorial: On";
      }
    });
  }

  int getGameSizeX() {
    return game.fixedFieldWidth;
  }

  int getGameSizeY() {
    return game.fixedFieldHeight;
  }

  void tutorialButtonListener() {
    field.tutorialButton.onClick.listen((MouseEvent ev) {
      field.removeTutorialView();
    });
  }

  void tutorial(String expl, message) {
    if (tutorialOn) {
      field.showTutorialView(expl, message);
    }
  }

}




