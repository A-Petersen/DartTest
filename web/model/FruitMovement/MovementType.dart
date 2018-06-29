import '../Vector.dart';

/**
 * Die abstrakte Klasse MovementType dient als Grundlage für die Erstellung diverser Bewegungen
 */
abstract class MovementType {
  /**
   * Vektor enthält [x] und [y] Koordinate
   */
  Vector vector;

  /**
   * Konstruktor stellt sicher, dass ein neuer Vektor erstellt wird.
   */
  MovementType() {
    this.vector = new Vector();
  }

  /**
   * Diese Methode muss implementiert werden und beschreibt die Logik des Movements. Sie wird von den UFOs aufgerufen.
   */
  Vector move(double speed);

  /**
   * toString() sollte die Art des Movements als String implementieren.
   */
  String toString();

  /**
   *
   */
  double getSpecial();
}