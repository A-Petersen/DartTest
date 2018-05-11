import 'Field.dart';
import 'Fruit.dart';

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
  double destX;

  /**
   * Zielkoordinate Y der folgenden Bewegung
   */
  double destY;

  Field field;

  /**
   * Konstruktor - unfertig...
   */
  Figure(this.x, this.y, this.a, this.b, this.field,);

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
    if (f.left > this.left + 28 && f.left < this.left + 42) return true;
    return false;
  }

  /**
   * Methode zum setzen des Ziels der kommenden Bewegung
   */
  void move(double destX, [double destY = 0.0]) {
    this.destX = destX;
    this.destY = destY;
  }

  /**
   * TODO Update - Kontrolle für bewegungen außerhalb des Spiuelbereich fehlen noch !!!
   */
  void update() {
    this.x += destX;
  }
}