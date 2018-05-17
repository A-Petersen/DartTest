import 'dart:html';
import 'dart:math';
import '../model/Fruit.dart';
import '../model/Figure.dart';

class Field {

  final frank = querySelector("#frank");
  final score = querySelector("#score");

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

    var fruit = querySelector(f.idFruit);
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
  }

  void setScore(int s) {
    score.text = s.toString();
  }


}