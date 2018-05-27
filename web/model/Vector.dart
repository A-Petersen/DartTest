class Vector{
  double _x;
  double _y;

  Vector([this._x = 0.0, this._y = 0.0]);

  // eingentlich nicht notwendig...
  double get x => (this._x);
  set x(double x) => _x = x;
  double get y => (this._y);
  set y(double y) => _y = y;

  Vector setVector (double x, double y) {
    this._x = x;
    this._y = y;
    return this;
  }

}