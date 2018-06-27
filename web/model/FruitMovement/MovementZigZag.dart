import '../Vector.dart';
import 'MovementType.dart';

class MovementZigZag extends MovementType {

  /**
   * Hilfsvariable um festzustellen, ob die gewünschte Breite ausgeschöpft wurde
   */
  int counter = 0;

  /**
   * Beschreibt die halbe Breite der Zick-Zack Bewegung in Pixeln bezogen auf das Game Spielfeld (derzeit 640x360)
   */
  int zigzagWidth;

  /**
   * Geschwindigkeit in Pixeln pro TimerTick
   */
  double zigzagSpeed;

  /**
   * Sagt aus, ob das UFO sich derzeit in der Linksbewegung befindet
   */
  bool goLeft = false;

  /**
   * Konstruktor – MovementCircle
   * Beschreibt die Art der Zick-Zack Bewegung mittels [zigzagWidth] und [zigzagSpeed].
   */
  MovementZigZag(this.zigzagWidth, this.zigzagSpeed);

  /**
   * Beschreibt die Logik des Movements und benötigt [speed] um die grundsätzliche Bewegung zu berücksichtigen.
   */
  Vector move(double speed) {

    vector.x = speed;

    if (!goLeft) {
      vector.x = (vector.x + (zigzagSpeed - speed));
      counter++;
    }
    if (goLeft) {
      vector.x = (vector.x - zigzagSpeed);
      counter--;
    }
    if (goLeft && counter < -zigzagWidth) goLeft = false;
    if (!goLeft && counter > zigzagWidth) goLeft = true;

    return vector;
  }

  /**
   * Gibt die Art des Movement-Objektes als String aus.
   */
  String toString() {
    return 'ZigZag';
  }
}