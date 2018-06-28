import '../Vector.dart';
import 'MovementType.dart';
import 'dart:math';

/**
 * Erbt von MovementType und beschreibt eine Kreisbewegung
 */
class MovementCircle extends MovementType {

  /**
   * Hilfsvariable für das Zwischenspeichern des Winkels
   */
  double angle = 0.0;

  /**
   * Beschreibt mit welcher Geschwindigkeit (pro TimerTick) sich der Winkel
   */
  double angleWidth;

  /**
   * Abstand zum berechneten Punkt. Beeinflusst ebenfalls die Geschwindigkeit
   */
  double radius;

  /**
   * Konstruktor – MovementCircle
   * Beschreibt die Art des Kreises mittels [angleWidth] und [radius].
   */
  MovementCircle(this.angleWidth, this.radius);

  /**
   * Beschreibt die Logik des Movements und benötigt [speed] um die grundsätzliche Bewegung zu berücksichtigen.
   */
  Vector move(double speed) {

    vector.x = (radius * sin(angle));
    vector.y = (radius * cos(angle));

    angle = (angle + angleWidth) % 360;

    vector.x += speed;

    return vector;
  }

  /**
   * Gibt die Art des Movement-Objektes als String aus.
   */
  String toString() {
    return 'Circle';
  }
}