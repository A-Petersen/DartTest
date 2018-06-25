import '../controller/Controller.dart';
import '../model/FruitObject/AbstractUFO.dart';
import '../model/FruitObject/Bomb.dart';
import 'dart:html';
import 'dart:math';
import '../model/FruitObject/Fruit.dart';
import '../model/Figure.dart';

class Field {
  Controller controller;

  final figure = querySelector("#frank");
  final score = querySelector("#score");
  final level = querySelector("#level");
  final korb = querySelector("#korb");
  final attemps = querySelector("#attemps");

  final leftSite = querySelector("#leftSite");
  final rightSite = querySelector("#rightSite");

  final startScreen = querySelector("#startScreen");
  final startButtonStartScreen = querySelector("#startButtonStartScreen");
  final tutorialButtonStartScreen = querySelector("#tutorialButtonStartScreen");
  final highscoreStartScreen = querySelector("#highscoreStartScreen");

  final orientationInfo = querySelector("#orientationInfo");
  final startButton = querySelector("#startButton");

  final tutorialWindow = querySelector("#tutorialWindow");
  final tutorialMessage = querySelector("#tutorialMessage");
  final tutorialButton = querySelector("#tutorialButton");
  final tutorialPicture = querySelector("#tutorialPicture");

  final gameoverScreen = querySelector("#gameoverScreen");
  final endscore = querySelector("#endscore");
  final highscore = querySelector("#highscore");
  var resetButton = querySelector("#resetButton");

  final fieldQuery = querySelector('#field');

  Map<AbstractUFO, DivElement> ufos = new Map();

  /**
   * Breite der gesamt View
   */
  int get width => window.innerWidth;

  /**
   * Höhe der gesamt View
   */
  int get height => window.innerHeight;

  int get size => min(this.width, this.height);

  int state = 0;

  Field(this.controller) {
  }

  void updateUFOs(AbstractUFO ufo) {
    ufo.update();

    var ufoStyle = querySelector("#" + ufos[ufo].id);

    ufoStyle.style.top = "${getViewPos(false, ufo.heaven)}px";
    ufoStyle.style.left = "${getViewPos(true, ufo.left)}px";
    ufoStyle.style.transform = "rotate(${(getViewPos(true, ufo.x.floor()) * 2 + getViewPos(false, ufo.y.floor())) % 360}deg)";
  }

  void updateFigure(Figure f) {
    f.update();

    this.figure.style.left = "${getViewPos(true, f.left)}px";

    if (controller.game.figure.moving == 2) {
      this.figure.style.transform = "scaleX(-1)";
    } else {
      this.figure.style.transform = "scaleX(1)";
    }
    if (controller.game.figure.moving != 0) {
      switch (state) {
        case 10:
          this.figure.style.backgroundImage = "url('resources/frank_mid.png')";
          break;
        case 20:
          this.figure.style.backgroundImage = "url('resources/frank_late.png')";
          break;
        case 30:
          this.figure.style.backgroundImage = "url('resources/frank_mid.png')";
          break;
        case 40:
          this.figure.style.backgroundImage = "url('resources/frank.png')";
          state = -1;
          break;
      }
      state++;
    } else {
      this.figure.style.backgroundImage = "url('resources/frank.png')";
    }
    this.figure.style.backgroundImage = "url('resources/frank.png')";
  }

  void createNewUFO(AbstractUFO ufo) {
    final round = "${this.size}px";

    var ufoDiv = new DivElement();
    ufoDiv.id = 'ufo' + AbstractUFO.getID().toString();

    ufoDiv.style.width = "${getViewPos(true, ufo.width)}px";
    ufoDiv.style.height = "${getViewPos(false, ufo.height)}px";
    ufoDiv.style.borderRadius = round;

    switch (ufo.getClassName()) {
      case 'Fruit':
        {
          switch (ufo.type) {
            case 1:
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/bananen.png")';
                ufoDiv.style.backgroundSize = '100% 100%';
                ufoDiv.style.zIndex = '1';
                break;
              }
            case 2:
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/birne.png")';
                ufoDiv.style.zIndex = '1';
                ufoDiv.style.backgroundSize = '100% 100%';
                break;
              }
            case 3:
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/apfel.png")';
                ufoDiv.style.zIndex = '1';
                ufoDiv.style.backgroundSize = '100% 100%';
                break;
              }
            case 4:
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/blatt.png")';
                ufoDiv.style.zIndex = '1';
                ufoDiv.style.backgroundSize = '100% 100%';
                break;
              }
          }
          break;
        }
      case 'Bomb':
        {
          ufoDiv.style.position = 'absolute';
          ufoDiv.style.backgroundImage = 'url("resources/bomb.png")';
          ufoDiv.style.zIndex = '1';
          ufoDiv.style.backgroundSize = '100% 100%';
          break;
        }
      case 'Smoothie':
        {
          ufoDiv.style.position = 'absolute';
          ufoDiv.style.backgroundImage = 'url("resources/smoothie.png")';
          ufoDiv.style.zIndex = '1';
          ufoDiv.style.backgroundSize = '100% 100%';
          break;
        }
      case 'Heart':
        {
          ufoDiv.style.position = 'absolute';
          ufoDiv.style.backgroundImage = 'url("resources/herts.png")';
          ufoDiv.style.zIndex = '1';
          ufoDiv.style.backgroundSize = '100% 100%';
          break;
        }
    }
    fieldQuery.children.add(ufoDiv);
    ufos[ufo] = ufoDiv;
  }

  void removeUFO(AbstractUFO ufo) {
    ufos[ufo].remove();
    ufos.remove(ufo);
  }

  void setScore(int s) {
    score.text = s.toString();
  }

  void setLevel(int l) {
    level.text = "Level " + l.toString();
  }

  void setAttempts(int a) {
    attemps.style.width = "${5 * a}%";
    attemps.style.backgroundSize = "${100 / a}% 100%";
  }

  void gameover() {
    attemps.style.visibility = "hidden";
    gameoverScreen.style.visibility = "visible";
    gameoverScreen.style.zIndex = "2";
    ufos.forEach((u, d) => d.remove());
    endscore.text = "Score: " + score.text;
    highscore.text = "Highscore: " + controller.getHighscore().toString();
  }

  void reset() {
    startButton.text = "Start";
    ufos = new Map();
    gameoverScreen.style.zIndex = "-2";
    gameoverScreen.style.visibility = "hidden";
    score.text = "0";
    attemps.style.visibility = "visible";
  }

  void showOrientationInfo() {
    orientationInfo.style.visibility = "visible";
    orientationInfo.style.zIndex = "2";
  }

  void hideOrientationInfo() {
    orientationInfo.style.visibility = "hidden";
    orientationInfo.style.zIndex = "-2";
  }

  void initField() {
    startButton.text = "Fortfahren";
  }

  void initStartScreen() {
    highscoreStartScreen.text = "Highscore: " + controller.highscore.toString();
  }

  void removeStartScreen() {
    startScreen.remove();
  }

  double getViewPos(bool needXPos, int gamePos) {
    return needXPos
        ? (gamePos / controller.getGameSizeX()) * width
        : (gamePos / controller.getGameSizeY()) * height;
  }

  void showTutorialView(String tutorial, String message) {
    tutorialWindow.style.zIndex = "3";
    switch (tutorial) {
      case "Banane": {
        tutorialPicture.style.background = 'url("resources/bananen.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
      case "Movement": {
        tutorialPicture.style.background = 'url("resources/frank.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
      case "Smoothie": {
        tutorialPicture.style.background = 'url("resources/smoothie.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
      case "Bomb": {
        tutorialPicture.style.background = 'url("resources/bomb.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
      case "Heart": {
        tutorialPicture.style.background = 'url("resources/herts.png")';
        tutorialPicture.style.backgroundSize = "contain";
        tutorialPicture.style.backgroundRepeat = "no-repeat";
        tutorialMessage.text = message;
        break;
      }
    }
    tutorialWindow.style.visibility = "visible";
    controller.running = false;
  }

  void removeTutorialView() {
    tutorialWindow.style.zIndex = "-1";
    tutorialWindow.style.visibility = "hidden";
    controller.running = true;
  }
}
