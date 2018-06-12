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

  final gameoverScreen = querySelector("#gameoverScreen");
  final endscore = querySelector("#endscore");
  final highscore = querySelector("#highscore");
  var resetButton = querySelector("#resetButton");

  final fieldQuery = querySelector('#field');

//  Map<Fruit, DivElement> fruits = new Map();
//  Map<Bomb, DivElement> bombs = new Map();
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

//  void updateFruit(Fruit f) {
//
//    f.update();
//
//    var fruit = querySelector("#" + fruits[f].id);
//    final round = "${this.size}px";
//
//    fruit.style.width="${f.width}px";
//    fruit.style.height="${f.width}px";
//    fruit.style.borderRadius=round;
//    fruit.style.top="${f.heaven}px";
//    fruit.style.left="${f.left}px";
//    fruit.style.backgroundSize="${f.width}px";
//
//    fruit.style.transform = "rotate(${(f.x*2 + f.y)%360}deg)";
//
//  }
//
//  void updateBombs(Bomb b) {
//    b.update();
//
//    var bomb = querySelector("#" + bombs[b].id);
//    final round = "${this.size}px";
//
//    bomb.style.width="${b.width}px";
//    bomb.style.height="${b.width}px";
//    bomb.style.borderRadius=round;
//    bomb.style.top="${b.heaven}px";
//    bomb.style.left="${b.left}px";
//    bomb.style.backgroundSize="${b.width}px";
//
//    bomb.style.transform = "rotate(${(b.x*2 + b.y)%360}deg)";
//  }

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

//  void createNewFruit(Fruit f) {
//    var fruitDiv = new DivElement();
//    fruitDiv.id = 'fruit' + Fruit.id.toString();
//    switch (f.type) {
//      case 1 :  {
//        fruitDiv.style.position = 'absolute';
//        fruitDiv.style.backgroundImage = 'url("resources/bananen.png")';
//        fruitDiv.style.zIndex = '1';
//        break;
//      }
//      case 2 :  {
//        fruitDiv.style.position = 'absolute';
//        fruitDiv.style.backgroundImage = 'url("resources/birne.png")';
//        fruitDiv.style.zIndex = '1';;
//        break;
//      }
//      case 3 :  {
//        fruitDiv.style.position = 'absolute';
//        fruitDiv.style.backgroundImage = 'url("resources/apfel.png")';
//        fruitDiv.style.zIndex = '1';
//        break;
//      }
//
//    }
//    fieldQuery.children.add(fruitDiv);
//    fruits[f] = fruitDiv;
//  }

//  void createNewBomb(Bomb b) {
//    var bombDiv = new DivElement();
//    bombDiv.id = 'bomb' + Bomb.id.toString();
//    switch (b.type) {
//      case 1 :  {
//        bombDiv.style.position = 'absolute';
//        bombDiv.style.backgroundImage = 'url("resources/bomb.png")';
//        bombDiv.style.zIndex = '1';
//        break;
//      }
//    }
//    fieldQuery.children.add(bombDiv);
//    bombs[b] = bombDiv;
//  }

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

//  void removeFruit(Fruit f) {
//    fruits[f].remove();
//    fruits.remove(f);
//  }
//
//  void removeBomb(Bomb b) {
//    bombs[b].remove();
//    bombs.remove(b);
//  }

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
//    fruits.forEach((f, d) => d.remove());
//    bombs.forEach((b, d) => d.remove());
    ufos.forEach((u, d) => d.remove());
    endscore.text = "Score: " + score.text;
    highscore.text = "Highscore: " + controller.getHighscore().toString();
  }

  void reset() {
//    fruits = new Map();
//    bombs = new Map();
    ufos = new Map();
    gameoverScreen.style.zIndex = "-2";
    gameoverScreen.style.visibility = "hidden";
    score.text = "0";
  }

  void showOrientationInfo() {
    orientationInfo.text = "Please use Landscape and refresh";
    orientationInfo.style.visibility = "visible";
  }

  void hideOrientationInfo() {
    orientationInfo.remove();
  }


}