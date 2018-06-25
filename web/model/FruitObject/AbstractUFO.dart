import '../Figure.dart';
import '../FruitMovement/MovementFactory.dart';
import '../FruitMovement/MovementType.dart';
import '../Vector.dart';


abstract class AbstractUFO {

  static int id = 0;

  static int getID() {
    return id;
  }

  void incrementID() {
    id++;
  }

  String getClassName ();

  int type;

  /**
   * X Position
   */
  double x;

  /**
   * Y Position
   */
  double y;

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

  double radius;
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

  bool hitGround() {
    return ground >= fieldHeight-5; //-5 weil der Ground der Frucht nicht == der Grund des Feldes.
  }

  bool onDrum(Figure f) {
    return y > fieldHeight - (f.b * 0.75) && f.onDrum(this);
  }

  bool landedInBasket() {
    return x >= (fieldWidth*0.87) && y >= (fieldHeight*0.9);
  }

}