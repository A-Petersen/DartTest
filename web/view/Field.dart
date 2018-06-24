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
  final attempts = querySelector("#attemps");

  final leftSide = querySelector("#leftSite");
  final rightSide = querySelector("#rightSite");

  final startScreen = querySelector("#startScreen");
  final startButtonStartScreen = querySelector("#startButtonStartScreen");
  final highscoreStartScreen = querySelector("#highscoreStartScreen");

  final orientationInfo = querySelector("#orientationInfo");
  final startButton = querySelector("#startButton");

  final gameoverScreen = querySelector("#gameoverScreen");
  final endscore = querySelector("#endscore");
  final highscore = querySelector("#highscore");
  final resetButton = querySelector("#resetButton");

  final fieldQuery = querySelector('#field');

  Map<AbstractUFO, DivElement> ufos = new Map();

  int state = 0;

  /**
   * Breite der gesamt View
   */
  int get width => window.innerWidth;

  /**
   * Höhe der gesamt View
   */
  int get height => window.innerHeight;

  int get size => min(this.width, this.height);

  Field(this.controller){
  }

  void updateUFOs(AbstractUFO ufo) {
    ufo.update();

    var ufoStyle = querySelector("#" + ufos[ufo].id);
//    final round = "${this.size}px";

//    width > height ? getViewPos(true,

//    ufoStyle.style.width="${getViewPos(true, ufo.width)}px";
//    ufoStyle.style.height="${getViewPos(false, ufo.height)}px";
//    ufoStyle.style.borderRadius=round;
    ufoStyle.style.top="${getViewPos(false, ufo.heaven)}px";
    ufoStyle.style.left="${getViewPos(true, ufo.left)}px";
//    ufoStyle.style.backgroundSize="${getViewPos(true, ufo.width)}px";
    ufoStyle.style.transform = "rotate(${(getViewPos(true, ufo.x.floor())*2 + getViewPos(false, ufo.y.floor()))%360}deg)";
//    ufoStyle.style.filter = 'drop-shadow(3px 3px 3px #222)';
  }

  void updateFigure(Figure f) {
    f.update();
    this.figure.style.left="${getViewPos(true, f.left)}px";
//    this.figure.style.top="${height - getViewPos(false,f.b.floor())}px";
//    this.figure.style.backgroundSize="${getViewPos(true, f.a.floor())}px ${getViewPos(false, f.b.floor())}px";
//    this.figure.style.backgroundSize = '100% 100%';

    if (controller.game.figure.moving == 2) {
      this.figure.style.transform="scaleX(-1)";
    }
    else {
      this.figure.style.transform="scaleX(1)";
    }
    if (controller.game.figure.moving != 0) {
      switch (state) {
        case 10:
          this.figure.style.backgroundImage="url('resources/frank_mid.png')";
          break;
        case 20:
          this.figure.style.backgroundImage="url('resources/frank_late.png')";
          break;
        case 30:
          this.figure.style.backgroundImage="url('resources/frank_mid.png')";
          break;
        case 40:
          this.figure.style.backgroundImage="url('resources/frank.png')";
          state = -1;
          break;
      }
      state++;
    } else {
      this.figure.style.backgroundImage="url('resources/frank.png')";
    }
    this.figure.style.backgroundImage="url('resources/frank.png')";
  }

  void createNewUFO(AbstractUFO ufo) {
    final round = "${this.size}px";

    var ufoDiv = new DivElement();
    ufoDiv.id = 'ufo' + AbstractUFO.getID().toString();

    ufoDiv.style.width="${getViewPos(true, ufo.width)}px";
    ufoDiv.style.height="${getViewPos(false, ufo.height)}px";
    ufoDiv.style.borderRadius=round;

    switch (ufo.getClassName()) {
      case 'Fruit' :
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
            case 2 :
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/birne.png")';
                ufoDiv.style.zIndex = '1';
                ufoDiv.style.backgroundSize = '100% 100%';
                break;
              }
            case 3 :
              {
                ufoDiv.style.position = 'absolute';
                ufoDiv.style.backgroundImage = 'url("resources/apfel.png")';
                ufoDiv.style.zIndex = '1';
                ufoDiv.style.backgroundSize = '100% 100%';
                break;
              }
            case 4 :
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
      case 'Bomb' :  {
        ufoDiv.style.position = 'absolute';
        ufoDiv.style.backgroundImage = 'url("resources/bomb.png")';
        ufoDiv.style.zIndex = '1';
        ufoDiv.style.backgroundSize = '100% 100%';
        break;
      }
      case 'Smoothie' : {
        ufoDiv.style.position = 'absolute';
        ufoDiv.style.backgroundImage = 'url("resources/smoothie.png")';
        ufoDiv.style.zIndex = '1';
        ufoDiv.style.backgroundSize = '100% 100%';
        break;
      }
      case 'Heart' : {
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
    attempts.style.width = "${5 * a}%";
    attempts.style.backgroundSize = "${100 / a}% 100%";
//    attemps.text = "Versuche: " + a.toString();
  }

  void gameover() {
    attempts.style.visibility = "hidden";
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
    attempts.style.visibility = "visible";
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

  void spin(DivElement div) {
    int spinV = 0;
    print(div.style.getPropertyValue("transform-rotateY"));
    print(div.style.getPropertyValue("transform").replaceAll("deg)", "").substring(7));
    //int spinV = double.parse(div.getAttribute("rotateY").replaceAll("deg)", "").substring(7)).toInt();
    //spinV = spinV == 360 ? 0 : spinV+5;
    //div.style.transform = "rotateY("+ spinV.toString() + "deg)";
  }

  double getViewPos(bool needXPos, int gamePos) {
    return needXPos ? (gamePos / controller.getGameSizeX()) * width :
    (gamePos/controller.getGameSizeY()) * height;
  }
}