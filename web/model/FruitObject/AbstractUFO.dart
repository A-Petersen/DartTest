import '../Figure.dart';
import '../FruitMovement/MovementFactory.dart';
import '../FruitMovement/MovementType.dart';
import '../Vector.dart';

/**
 * Ein AbstractUFO ist die Eltern-Klasse für alle Flugobjekte in dem Spiel.
 * Jedes Flugobjekt erbt von dieser Klasse.
 */
abstract class AbstractUFO {

  /**
   * Die Klasse hat eine fortlaufende ID, die jedes UFO abrufen kann
   */
  static int id = 0;

  /**
   * Ein UFO kann verschiedene Arten haben. Bei Früchten z.B. Bananen, Äpfel, Blätter...
   */
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
   * Breite des UFOs.
   */
  double a;

  /**
   * Höhe des UFOs.
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

  /**
   * Radius des UFOs.
   */
  double radius;

  /**
   * Vector für die Berechnung der Flugbahn
   */
  Vector vector = new Vector();

  /**
   * Fliegt das Objekt noch oder ist es schon auf den Boden gefallen
   */
  bool moving = true;

  /**
   * Ist das Objekt auf den Weg nach oben oder nach unten
   */
  bool goingUp = false;

  /**
   * Gravity des UFOs
   */
  double gravity;

  /**
   * Geschwindigkeit des UFOs
   */
  double speed;

  /**
   * Spielfeldbreite
   */
  int fieldWidth;

  /**
   * Spielfeldhöhe
   */
  int fieldHeight;

  /**
   * Die Art der Flugbahn des UFOs.
   * 0 -> normale Bewegung
   * 1 -> Zick-Zack
   * 2 -> kreisende Bewegung
   * 3 -> halb kreisende Bewegung
   */
  MovementType movementType = null;

  /**
   * Eine Factory zum erstellen von verschiedenen Bewegungen.
   */
  MovementFactory movementFactory = new MovementFactory();

  /**
   * Mitte des UFOs auf Y-Achse vom Himmel
   */
  int get heaven => (this.y - this.radius).floor();

  /**
   * Mittes des UFOs auf Y-Achse vom Boden
   */
  int get ground => (this.y + this.radius).floor();

  /**
   * Mitte des UFOs auf X-Achse von Rechts
   */
  int get left   => (this.x - this.radius).floor();

  /**
   * Mitte des UFOs auf X-Achse von Links
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
    // Findet Movementmanipulation statt
    if (movementType == null) { //movementType == null == Standard-Bewegung
      moveGravity();
      this.destX = speed;
    } else {
      moveGravity();
      // destX und Y dienen dem Simulieren des Normalverlaufs bei Movementmanipulation
      this.destX += speed;
      // Ziehe die alte Manipulation des Punktes ab
      this.destX -= vector.x;
      this.destY -= vector.y;
      vector = movementType.move(this.speed);
      // Addiere die Manipulation des Punktes
      this.destX += vector.x;
      this.destY += vector.y;
    }
  }

  /**
   * Berechnung der Gravitation
   */
  void moveGravity() {
    double gravityFactor = (y <= 1 ? 0.95 : (y / 320));
    double newY = gravityFactor * (goingUp ? (-1) * gravity : gravity);
    this.destY += newY;
    // Findet Movementmanipulation statt
    if (movementType == null) {
      this.destY = newY;
    } else {
      // destX und Y dienen dem Simulieren des Normalverlaufs
      this.destY += newY;
    }
  }

  /**
   * Update
   */
  void update() {
    // Findet Movementmanipulation statt
    if (movementType == null) {
      this.x += destX;
      this.y += destY;
    } else {
      // destX und Y dienen dem Simulieren des Normalverlaufs
      this.x = destX;
      this.y = destY;
    }


    if (this.goingUp && (this.y - this.radius <= 11) ) this.goingUp = false;

    if (this.heaven < 0) this.y = this.radius;
    if (this.ground > this.fieldHeight - 1) this.y = this.fieldHeight - 1 - this.radius;

    if (this.left < 0) this.x = this.radius;
    if (this.right > this.fieldWidth - 1) this.x = this.fieldWidth - 1 - this.radius;
  }

  /**
   * Funktion zur Überprüfung, ob die Frucht auf den Boden gefallen ist
   */
  bool hitGround() {
    return ground >= fieldHeight-5; //-5 weil der Ground der Frucht nicht == der Grund des Feldes.
  }

  /**
   * Funktion zur Überprüfung, ob die Frucht auf die Trommel der Figur gefallen ist
   */
  bool onDrum(Figure f) {
    return y > fieldHeight - (f.b * 0.75) && f.onDrum(this);
  }

  /**
   * Funktion zur Überprüfung, ob die Frucht in dem Korb gelandet ist
   */
  bool landedInBasket() {
    return x >= (fieldWidth*0.87) && y >= (fieldHeight*0.9);
  }

  static int getID() {
    return id;
  }

  void incrementID() {
    id++;
  }

  String getClassName();

}