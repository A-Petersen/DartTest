import '../Vector.dart';
import 'MovementType.dart';
import 'dart:math';

/**
 * Erbt von MovementType und beschreibt eine Kreisbewegung
 */
class MovementHalfCircle extends MovementType {



  /**
   * max. Winkel
   */
  double angleMax = 220.0;

  /**
   * min. Winkel
   */
  double angleMin = 130.0;

  /**
   * Hilfsvariable für das Zwischenspeichern des Winkels
   */
  double angle = 130.0;

  /**
   * Beschreibt mit welcher Geschwindigkeit (pro TimerTick) sich der Winkel
   */
  double angleWidth;

  /**
   * Abstand zum berechneten Punkt. Beeinflusst ebenfalls die Geschwindigkeit
   */
  double radius;

  /**
   * Befindet sich in Linksbewegung
   */
  bool goLeft = false;
  /**
   * Konstruktor – MovementHalfCircle
   * Beschreibt die Art des Kreises mittels [angleWidth], [radius], [angleMin] und [angleMax].
   */
  MovementHalfCircle(this.angleWidth, this.radius, this.angleMin, this.angleMax) {
    angle = angleMin;
  }

  /**
   * Beschreibt die Logik des Movements und benötigt [speed] um die grundsätzliche Bewegung zu berücksichtigen.
   */
  Vector move(double speed) {

    if (angle <= angleMax && !goLeft) {
      angle += angleWidth;
      if (angle >= angleMax) goLeft = true;
    }

    if (angle >= angleMin && goLeft) {
      angle -= angleWidth;
      if (angle <= angleMin) goLeft = false;
    }

    vector.x = (-1)*(radius * sin(angle/180*PI));
    vector.y = (-1)*(radius * cos(angle/180*PI));

    return vector;
  }

  /**
   * Gibt die Art des Movement-Objektes als String aus.
   */
  String toString() {
    return 'Circle';
  }
  @override
  double getSpecial() {
    return angle * (-1.0) - 180;
  }
}