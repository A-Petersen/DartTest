import '../view/Field.dart';
import 'AbstractFruit.dart';
import 'FruitDecorator/MovementFactory.dart';
import 'FruitDecorator/MovementType.dart';
import 'dart:html';


class Fruit {

  static int id = 0;

  int type;

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

  bool moving = true;

  bool goingUp = false;

  double gravity;

  double speed;

  Field field;

  MovementType movementType = null;

  MovementFactory movementFactory = new MovementFactory();

  /**
   * Konstruktor
   */
  Fruit(x, y, radius, field, type, [movementType = null, gravity = 10.0, speed = 1.0]) {
    this.x = x;
    this.y = y;
    this.field = field;
    this.radius = radius;
    this.gravity = gravity;
    this.speed = speed;
    id += 1;
    this.type = type;
    if (movementType != null) this.movementType = movementFactory.newMevement(movementType, this);
  }

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
  int get width => (4 * this.radius).floor();

  /**
   * Höhe
   */
  int get height => (4 * this.radius).floor();

  /**
   * Methode zum setzen des Ziels der kommenden Bewegung
   */
  void move() {
    if (movementType == null) {
      double hoeheInProzent = (y <= 1 ? 0.95 : (y / 320)); // 0.x
      double yMerk = hoeheInProzent * (goingUp ? (-1) * gravity : gravity);
      this.destX = speed;
      this.destY = yMerk;
      print('MovementType: ' + movementType.toString());
    } else {
      movementType.move();
      print('MovementType: ' + movementType.toString());
    }
  }

  /**
   * Position des Objektes setzten.
   */
  void position(double posX, double posY) {
    this.x = posX;
    this.y = posY;
  }

  /**
   * Update
   */
  void update() {
    this.x += destX;
    this.y += destY;

    if (this.goingUp && (this.y - this.radius <= 11) ) this.goingUp = false;

    if (this.heaven < 0) this.y = this.radius;
    if (this.ground > this.field.height - 1) this.y = this.field.height - 1 - this.radius;

    if (this.left < 0) this.x = this.radius;
    if (this.right > this.field.width - 1) this.x = this.field.width - 1 - this.radius;
  }

}