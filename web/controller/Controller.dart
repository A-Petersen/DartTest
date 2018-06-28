import '../model/Game.dart';
import '../model/Level.dart';
import '../model/Tutorial.dart';
import '../view/Field.dart';
import 'dart:convert';
import 'dart:html';
import 'dart:async';

/**
 * Beschreibt den Namen für die JSON, in dem das Levelkonzept und das Tutorial liegt.
 */
const levelconceptAndTutorial = 'Levelkonzept.json';

/**
 * Der Controller reagiert auf seine Listener und auf Benachrichtigungen von dem Model.
 * Dafür erstellt er für verschiede Buttons und DivElemente Listener und übergibt dem Model Funktionen,
 * die das Model aufrufen kann. Außerdem reagiert er auf seine Timer.
 */
class Controller {

  /**
   * Das Spielfeld, bzw. die Schnittstelle zur View
   */
  Field field;

  /**
   * Die Schnittstelle zum Model
   */
  Game game;

  /**
   * Der Timer für die Funktion run
   */
  Timer timerRun;

  /**
   * Der Timer für die Funktion CheckUFO
   */
  Timer timerCheckUFO;

  /**
   * Wert für den Haupt-Intervall
   */
  Duration runIntervall = new Duration(milliseconds: 30);

  /**
   * Wert für den Intervall, in dem die UFOs geprüft und geworfen werden sollen
   */
  Duration checkUFOIntervall = new Duration(milliseconds: 4000);

  /**
   * Boolean-Wert, der angibt ob das Spiel läuft.
   */
  bool running = true;

  /**
   * Boolean-Wert, der angibt, ob das Spiel erfolgreich initialisiert wurde
   */
  bool initSucces = false; //Ob das Spiel bereits initalsiert wurde (erfolgreich)

  /**
   * Highscore des Spieles
   */
  int highscore;

  /**
   * Boolean-Wert, der angibt, ob die Level und das Tutorial geladen wurde
   */
  bool loading = false;

  /**
   * Boolean-Wert, der angibt, ob das Tutorial angezeigt werden soll
   */
  bool tutorialOn = true;

  /**
   * Der Konstruktor.
   * Erwartet einen Wert für den Highscore.
   */
  Controller(this.highscore) {
    field = new Field(this); //Initalisierung des Feldes
    startScreenButtonsListener();
    tutorialButtonListener();
    field.initStartScreen();
  }

  /**
   * Funktion, die das Spiel initalisieren soll.
   */
  Future init() async {
    orientationInfoStartButtonListener();
    if (checkForOrientation()) {
      initSucces = true;
      field.initField();
      game = new Game(highscore, field.updateUFOs, field.removeUFO, field.createNewUFO, tutorial);
      touchListener();
      resetButtonListener();
      if (!loading) await setLevel();
      startNewGame();
    }
  }

  /**
   * Startet ein neues Spiel
   */
  void startNewGame() {
    timerRun = new Timer.periodic(runIntervall, (Timer t) => run());
    timerCheckUFO = new Timer.periodic(checkUFOIntervall, (Timer t) => checkUFOs());
    checkUFOs();
    run();
  }

  /**
   * Lässt das Model prüfen, ob neue UFOs geworfen werden müssen/können und
   * lässt das Level ggf. auf dem Field aktualisieren
   */
  void checkUFOs() {
    if (running) {
      game.checkUFOs();
      field.setLevel(game.checkLevel());
    }
  }

  /**
   * Diese Funktion wird von dem Timer timerRun aktiviert.
   * Prüft die Orientation.
   * Lässt das Model den nächsten Zustand der Objekte berechnen.
   * Lässt die Field die Darstellung anpassen.
   * Prüft, ob das Spiel vorbei (Gameover) ist.
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
   * Steuerung für die Spielfigur
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

  /**
   * Listener für den Reset Button
   */
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




