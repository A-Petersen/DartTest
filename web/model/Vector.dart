/**
 * Vector enthält eine x und ein y Koordinate und dient der Handhabung von Punkten bzw. Ziel-Koordinaten
 */
class Vector{
  /**
   * x Koordinate
   */
  double _x;

  /**
   * y Koordinate
   */
  double _y;

  /**
   * Konstruktor für den Vektor. [_x] und [_y] können angegeben werden, falls nicht ist der Default 0.0
   */
  Vector([this._x = 0.0, this._y = 0.0]);

  /**
   * Getter für [_x]
   */
  double get x => (this._x);
  /**
   * Setter für [_x]
   */
  set x(double x) => _x = x;
  /**
   * Getter für [_y]
   */
  double get y => (this._y);
  /**
   * Setter für [_y]
   */
  set y(double y) => _y = y;

  /**
   * Setter für den Vektor. [_x] und [_y] müssen angegeben werden.
   */
  Vector setVector (double x, double y) {
    this._x = x;
    this._y = y;
    return this;
  }

}