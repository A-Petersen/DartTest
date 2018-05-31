import 'dart:html';
import 'dart:math';
import '../model/Fruit.dart';
import '../model/Figure.dart';

class Field {

  final figure = querySelector("#frank");
  final score = querySelector("#score");
  final basket = querySelector("#basket");
  final treeRight = querySelector("#treeRight");
  final treeLeft = querySelector("#treeLeft");

  final gameoverScreen = querySelector("#gameoverScreen");
  final endscore = querySelector("#endscore");
  final highscore = querySelector("#highscore");
  var resetButton = querySelector("#resetButton");

  final fieldQuery = querySelector('#field');

  Map<Fruit, DivElement> fruits = new Map();

  /**
   * Breite der gesamt View
   */
  int get width => window.screen.available.width;

  /**
   * Höhe der gesamt View
   */
  int get height => window.screen.available.height;

  int get size => min(this.width, this.height);

  double get center_x => this.width / 2;

  double get center_y => this.height / 2;

  void updateFruit(Fruit f) {

    f.update();

    var fruit = querySelector("#" + fruits[f].id);
    final round = "${this.size}px";

    fruit.style.width="${f.width}px";
    fruit.style.height="${f.width}px";
    fruit.style.borderRadius=round;
    fruit.style.top="${f.heaven}px";
    fruit.style.left="${f.left}px";
    fruit.style.backgroundSize="${f.width}px";

    fruit.style.transform = "rotate(${(f.x*2 + f.y)%360}deg)";

  }

  void updateFigure(Figure f) {
    f.update();
    this.figure.style.left="${f.left}px";
    this.figure.style.top="${height - f.b}px";
    this.figure.style.backgroundSize="${f.a}px ${f.b}px";
  }

  void createNewFruit(Fruit f) {
    var fruitDiv = new DivElement();
    fruitDiv.id = 'fruit' + Fruit.id.toString();
    switch (f.type) {
      case 1 :  {
        fruitDiv.style.position = 'absolute';
        fruitDiv.style.backgroundImage = 'url("resources/bananen.png")';
        fruitDiv.style.zIndex = '1';
        break;
      }
      case 2 :  {
        fruitDiv.style.position = 'absolute';
        fruitDiv.style.backgroundImage = 'url("resources/birne.png")';
        fruitDiv.style.zIndex = '1';;
        break;
      }
      case 3 :  {
        fruitDiv.style.position = 'absolute';
        fruitDiv.style.backgroundImage = 'url("resources/apfel.png")';
        fruitDiv.style.zIndex = '1';
        break;
      }

    }
    fieldQuery.children.add(fruitDiv);
    fruits[f] = fruitDiv;
  }

  void removeFruit(Fruit f) {
    fruits[f].remove();
    fruits.remove(f);
  }

  void setScore(int s) {
    score.text = s.toString();
  }
  
  bool inKorb(Fruit f) {
    //if (f.ground >= int.parse(korb.style.top.replaceAll("px", "")) )
      return false;
  }

  //TODO HIGHSCORE
  void gameover() {
    gameoverScreen.style.visibility = "visible";
    fruits.forEach((f, d) => d.remove());
    endscore.text = "Score: " + score.text;
  }

  void reset() {
    fruits = new Map();
    gameoverScreen.style.visibility = "hidden";
  }

  void createTreesAndBasketAndFigure() {
    print("hello there");
//    basket.style.width="${(width * 0.125)}px";
//    basket.style.height="${(height * 0.22)}px";
//    basket.style.backgroundSize="${(height * 0.22)}px ${(width * 0.125)}px";
//    basket.style.bottom="${0}px";
  }
}