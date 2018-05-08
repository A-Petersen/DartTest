import 'dart:html';
import 'dart:math';
import 'fruit.dart';

class Field {
  final fruit = querySelector("#fruit");
  /**
   * Breite der gesamt View
   */
  int get width => window.innerWidth;

  /**
   * Höhe der gesamt View
   */
  int get height => window.innerHeight;

  double get center_X => this.width / 2;

  double get center_y => this.height / 2;

  int get size => min(this.width, this.height);


  void update(Fruit a) {

    a.update();

    final round = "${this.size}px";

    this.fruit.style.width="${a.width}px";
    this.fruit.style.height="${a.width}px";
    this.fruit.style.borderRadius=round;
    this.fruit.style.top="${a..heaven}px";
    this.fruit.style.left="${a.left}px";
  }
}