import '../view/Field.dart';
import 'FruitObject/Fruit.dart';

class Figure {
  /**
   * X Position
   */
  double x;

  /**
   * Y Position
   */
  double y;

  /**
   * Breite des Figuren-Feldes
   */
  double a;

  /**
   * Höhe des Figuren-Feldes
   */
  double b;

  /**
   * Zielkoordinate X der folgenden Bewegung
   */
  double destX = 0.0;

  /**
   * Zielkoordinate Y der folgenden Bewegung
   */
  double destY;

  double speed;

  int moving = 0;

  int fieldWidth;
  int fieldHeight;

  /**
   * Konstruktor - unfertig...
   */
  Figure(this.x, this.y, this.a, this.b, this.fieldWidth, this.fieldHeight, [this.speed = 20.0]);

  /**
   * Mitte der Figur auf Y-Achse vom Himmel
   */
  int get heaven => (this.y - (this.b / 2)).floor();

  /**
   * Mitte der Figur auf Y-Achse vom Boden
   */
  int get ground => (this.y + (this.b / 2)).floor();

  /**
   * Mitte der Figur auf X-Achse von Rechts
   */
  int get left   => (this.x - (this.a / 2)).floor();

  /**
   * Mitte der Figur auf X-Achse von Links
   */
  int get right  => (this.x + (this.a / 2)).floor();

  /**
   * Breite
   */
  int get width => this.a.floor();

  /**
   * Höhe
   */
  int get hight => this.b.floor();

  bool onDrum(Fruit f) {
    if (f.ground >= this.heaven && f.right > this.left + 20 && f.left < this.right) return true;
    return false;
  }

  /**
   * Methode zum setzen des Ziels der kommenden Bewegung
   */
  void move() {
    switch (moving) {
      case (1):
        this.destX = speed;
        break;
      case (2):
        this.destX = (-1) * speed;
        break;
      case (0):
        this.destX = 0.0;
        break;
    }
  }

  /**
   * TODO Update - Kontrolle für bewegungen außerhalb des Spiuelbereich fehlen noch !!!
   */
  void update() {
    if (destX < 0 && x <= 0) destX = 0.0;
    if (destX > 0 && x >= fieldWidth) destX = 0.0;
    this.x += destX;
  }
}