import '../view/Field.dart';

abstract class AbstractFruit {

  static int id = 0;

//  int getId() {
//    return id;
//  }

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



  /**
   * Mitte des Objekts auf Y-Achse vom Himmel
   */
  int get heaven;

  /**
   * Mittes des Objekts auf Y-Achse vom Boden
   */
  int get ground;

  /**
   * Mitte des Objekts auf X-Achse von Rechts
   */
  int get left;

  /**
   * Mitte des Objekts auf X-Achse von Links
   */
  int get right;

  /**
   * Breite
   */
  int get width;

  /**
   * Höhe
   */
  int get height;

  void move();

  /**
   * Position des Objektes setzten.
   */
  void position(double posX, double posY);

  /**
   * Update
   */
  void update();
}