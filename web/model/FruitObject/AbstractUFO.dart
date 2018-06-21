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
  void move();

  void moveGravity();

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
  void update();

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