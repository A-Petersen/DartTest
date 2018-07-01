import 'AbstractUFO.dart';
import 'Bomb.dart';
import 'Fruit.dart';
import 'Heart.dart';
import 'Smoothie.dart';
import 'dart:math';

/**
 * Die UFOFactor erstellt verschiedene UFOs, anhand der Funktion und dem Type.
 */
class UFOFactory {

  /**
   * Spielfeldgröße
   */
  int fieldWidth, fieldHeight;

  /**
   * Radius der UFOs, alle UFOs haben standardmässig den gleichen Radius
   */
  double radius;

  UFOFactory(this.fieldWidth, this.fieldHeight) {
    this.radius = fieldWidth * 0.015 > fieldHeight * 0.015 ? fieldWidth * 0.015 : fieldHeight * 0.015; //Radius wird berechnet anhand der Spielfeldgröße.
  }

  /**
   * Funktion für eine neue Frucht.
   * Erwartet einen Wert für die Art der Frucht und einen Wert für die Bewegungsart.
   * z.B. [type] = 1, [movement] = null ergibt eine Banane mit der default Bewegung
   */
  AbstractUFO newFruit(int type, int movement) {
    switch (type) {
      case 1 : return new Fruit(0.0, 0.0, radius, 1, fieldWidth, fieldHeight, movement, 10.0, 1.0);
      case 2 : return new Fruit(0.0, 0.0, radius, 2, fieldWidth, fieldHeight, movement, 5.0, 1.5);
      case 3 : return new Fruit(0.0, 0.0, radius, 3, fieldWidth, fieldHeight, movement, 15.0, 2.0);
      case 4 : return new Fruit(50.0, 0.0, radius, 4, fieldWidth, fieldHeight, 3, 2.0, 0.5);
      default : return null;
    }
  }

  /**
   * Funktion für eine neue Bombe.
   * Erwartet einen Wert für die Art der Bombe und einen Wert für die Bewegungsart.
   */
  AbstractUFO newBomb(int type, int movement, double x) {
    switch (type) {
      case 1 : return new Bomb(x, -radius, radius, 0, fieldWidth, fieldHeight, movement, 25.0, 0.0);
      default : return null;
    }
  }

  /**
   * Funktion für einen neuen Smoothie.
   * Erwartet einen Wert für die Art des Smoothies und einen Wert für die Bewegungsart.
   */
  AbstractUFO newSmoothie(int type, int movement) {
    double x = new Random().nextInt(fieldWidth).toDouble();
    switch (type) {
      case 1 : return new Smoothie(x, -radius, radius, 0, fieldWidth, fieldHeight, movement, 10.0, 0.0);
      default : return null;
    }
  }

  /**
   * Funktion für ein neues Herz.
   * Erwartet einen Wert für die Art des Herzes und einen Wert für die Bewegungsart.
   */
  AbstractUFO newHearth(int type, int movement) {
    double x = new Random().nextInt(fieldWidth).toDouble();
    switch (type) {
      case 1 : return new Heart(x, 0.0, radius, 0, fieldWidth, fieldHeight, movement, 10.0, 0.0);
      default : return null;
    }
  }

}