import 'dart:html';
import 'dart:math';
import 'Fruit.dart';
import 'Figure.dart';

class Field {
//  final fruit = querySelector("#fruit");
  final frank = querySelector("#frank");
  List fruits;
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


  void updateFruit(Fruit a) {

    a.update();

    var fruit = querySelector(a.idFruit);
    final round = "${this.size}px";

    fruit.style.width="${a.width}px";
    fruit.style.height="${a.width}px";
    fruit.style.borderRadius=round;
    fruit.style.top="${a.heaven}px";
    fruit.style.left="${a.left}px";

  }

  void updateFigure(Figure f) {
    f.update();
    this.frank.style.left="${f.left}px";
  }

}