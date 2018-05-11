import 'dart:html';
import 'dart:math';
import 'Fruit.dart';
import 'Figure.dart';

class Field {
  final fruit = querySelector("#fruit");
  final frank = querySelector("#frank");
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


  void updateFruit(Fruit a) {

    a.update();

    final round = "${this.size}px";

    this.fruit.style.width="${a.width}px";
    this.fruit.style.height="${a.width}px";
    this.fruit.style.borderRadius=round;
    this.fruit.style.top="${a.heaven}px";
    this.fruit.style.left="${a.left}px";

  }

  void updateFigure(Figure f) {
    f.update();
    this.frank.style.left="${f.left}px";
  }

}