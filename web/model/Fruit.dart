import '../view/Field.dart';
import 'FruitMovement/MovementFactory.dart';
import 'FruitMovement/MovementType.dart';
import 'Vector.dart';


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
  double destX = 0.0;

  /**
   * Zielkoordinate Y der folgenden Bewegung
   */
  double destY = 0.0;

  Vector vector;

  bool moving = true;

  bool goingUp = false;

  double gravity;

  double speed;

  int fieldWidth;

  int fieldHeight;

  MovementType movementType = null;

  MovementFactory movementFactory = new MovementFactory();

  /**
   * Konstruktor
   */
  Fruit(this.x, this.y, this.radius, this.type, this.fieldWidth, this.fieldHeight, [movementType = null, this.gravity = 10.0, this.speed = 1.0]) {
    id += 1;
    this.movementType = movementFactory.newMovement(movementType, this);
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
      moveGravity();
      this.destX = speed;
    } else {
      moveGravity();
      vector = movementType.move(this.speed);
      this.destX = vector.x;
      this.destY += vector.y;
    }
  }

  void moveGravity() {
    double gravityFactor = (y <= 1 ? 0.95 : (y / 320)); // 0.x
    double newY = gravityFactor * (goingUp ? (-1) * gravity : gravity);
    this.destY = newY;
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
    if (this.ground > this.fieldHeight - 1) this.y = this.fieldHeight - 1 - this.radius;

    if (this.left < 0) this.x = this.radius;
    if (this.right > this.fieldWidth - 1) this.x = this.fieldWidth - 1 - this.radius;
  }

}