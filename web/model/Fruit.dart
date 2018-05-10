import 'Field.dart';
import 'dart:async';
import 'dart:html';


class Fruit {

  Timer timer;

  /**
   * X Position
   */
  double x;

  /**
   * Y Position
   */
  double y;

  double radius;

  /**
   * Breite des Objekt-Feldes
   */
  double a;

  /**
   * Höhe des Objekt-Feldes
   */
  double b;

  /**
   * Zielkoordinate X der folgenden Bewegung
   */
  double destX;

  /**
   * Zielkoordinate Y der folgenden Bewegung
   */
  double destY;

  double rangeX = 0.0;

  double rangeY = 0.0;

  Field field;

  /**
   * Konstruktor - unfertig...
   */
  Fruit(this.x, this.y, this.radius, this.field);

  /**
   * Mitte des Objekts auf Y-Achse vom Himmel
   */
  int get heaven => (this.y - this.radius).floor();

  /**
   * Mittes des Objekts auf Y-Achse vom Boden
   */
  int get ground => (this.y + this.radius).floor();

  /**
   * Mitte des Objekts auf X-Achse von Rechts
   */
  int get left   => (this.x - this.radius).floor();

  /**
   * Mitte des Objekts auf X-Achse von Links
   */
  int get right  => (this.x + this.radius).floor();

  /**
   * Breite
   */
  int get width => (2 * this.radius).floor();

  /**
   * Höhe
   */
  int get height => (2 * this.radius).floor();

  /**
   * Methode zum setzen des Ziels der kommenden Bewegung
   */
  void move(double destX, double destY) {
    this.destX = destX;
    this.destY = destY;
  }

  /**
   * Position des Objektes setzten.
   */
  void position(double posX, double posY) {
    this.x = posX;
    this.y = posY;
  }

  /**
   * Das Objekt bekommt eine Bewegung mitgegeben.
   * dx = wie weit soll sich die Fruit sich bewegen.
   * dy = wie hoch soll die Fruit sich bewegen.
   */
  void setMovement(double dx, double dy) {
    //Zuerst wird das Verhältnis von dx und dy berechnet, so dass die Fruit sich in einer Art Bogen bewegen kann.
    double x = dx;
    double y = dy;
    x = dx/dy;
    y = 1.0;

    //Dann wird geprüft, ob die Fruit sich nach oben oder nach unten bewegen muss.
    if (this.rangeX < dx/2) {
      this.move(x, y);
      this.rangeX+= x;
      this.rangeY+= y;
    } else {
      this.move(x, -y);
      this.rangeX+= x;
      this.rangeY+= y;
    }

    //Wurde die Bewegung abgeschlossen, soll sie von vorne beginnen.
    if (dx <= this.rangeX) {
      this.rangeX = 0.0;
      this.rangeY = 0.0;
      timer.cancel();
    }
    field.update(this);
    if (this.x == window.screen.width) timer.cancel();
  }

  void start(int time, double movementX, double movementY) {
    timer = new Timer.periodic(new Duration(milliseconds: time), (Timer t) => setMovement(movementX, movementY));
  }

  /**
   * Update
   */
  void update() {
    this.x += destX;
    this.y += destY;

    if (this.heaven < 0) this.y = this.radius;
    if (this.ground > this.field.height - 1) this.y = this.field.height - 1 - this.radius;

    if (this.left < 0) this.x = this.radius;
    if (this.right > this.field.width - 1) this.x = this.field.width - 1 - this.radius;
  }
}