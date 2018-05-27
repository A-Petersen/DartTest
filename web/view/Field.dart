import 'dart:html';
import 'dart:math';
import '../model/Fruit.dart';
import '../model/Figure.dart';

class Field {

  final frank = querySelector("#frank");
  final score = querySelector("#score");
  final korb = querySelector("#korb");
  final fieldQuery = querySelector('#field');
  Map<Fruit, DivElement> fruits = new Map();

  /**
   * Breite der gesamt View
   */
  int get width => 560;

  /**
   * Höhe der gesamt View
   */
  int get height => 315;

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
    this.frank.style.left="${f.left}px";
    this.frank.style.top="${f.field.height - f.b}px";
    this.frank.style.backgroundSize="${f.a}px ${f.b}px";
    print(korb.style.top);
  }

  void createNewFruit(Fruit f) {
    var fruitDiv = new DivElement();
    fruitDiv.id = 'fruit' + Fruit.id.toString();
//    print(f.type.toString);
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
        fruitDiv.style.zIndex = '1';;
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


}