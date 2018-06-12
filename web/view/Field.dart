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
  final korb = querySelector("#korb");

  final leftSite = querySelector("#leftSite");
  final rightSite = querySelector("#rightSite");

  final orientationInfo = querySelector("#orientationInfo");
  final startButton = querySelector("#startButton");

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

  double get center_x => this.width / 2;

  double get center_y => this.height / 2;

  int state = 0;

  Field(this.controller){
  }

  void updateUFOs(AbstractUFO ufo) {
    ufo.update();

    var ufoStyle = querySelector("#" + ufos[ufo].id);
    final round = "${this.size}px";

    ufoStyle.style.width="${ufo.width}px";
    ufoStyle.style.height="${ufo.width}px";
    ufoStyle.style.borderRadius=round;
    ufoStyle.style.top="${ufo.heaven}px";
    ufoStyle.style.left="${ufo.left}px";
    ufoStyle.style.backgroundSize="${ufo.width}px";

    ufoStyle.style.transform = "rotate(${(ufo.x*2 + ufo.y)%360}deg)";
  }

  void updateFigure(Figure f) {
    f.update();
    this.figure.style.left="${f.left}px";
    this.figure.style.top="${height - f.b}px";
    this.figure.style.backgroundSize="${f.a}px ${f.b}px";

    if (controller.game.figure.moving == 2) { this.figure.style.transform="scaleX(-1)"; }
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
  }

  void createNewUFO(AbstractUFO ufo) {
    var ufoDiv = new DivElement();
    ufoDiv.id = 'ufo' + AbstractUFO.getID().toString();
    switch (ufo.type) {
      case 1 :  {
        ufoDiv.style.position = 'absolute';
        ufoDiv.style.backgroundImage = 'url("resources/bananen.png")';
        ufoDiv.style.zIndex = '1';
        break;
      }
      case 2 :  {
        ufoDiv.style.position = 'absolute';
        ufoDiv.style.backgroundImage = 'url("resources/birne.png")';
        ufoDiv.style.zIndex = '1';;
        break;
      }
      case 3 :  {
        ufoDiv.style.position = 'absolute';
        ufoDiv.style.backgroundImage = 'url("resources/apfel.png")';
        ufoDiv.style.zIndex = '1';
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

  void gameover() {
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
  }

  void showOrientationInfo() {
    orientationInfo.style.visibility = "visible";
    orientationInfo.style.zIndex = "1000";
  }

  void hideOrientationInfo() {
    orientationInfo.style.visibility = "hidden";
    orientationInfo.style.zIndex = "-2";
  }

  void init() {
    startButton.text = "Fortfahren";
  }


}