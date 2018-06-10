class Level {
  int level = 1;
  int maxFruits = 3;
  int possibleFruits = 1;
  int possibleMovments = 0;

  Level() {
    new File('Levelkonzept')

  }

  void reset() {
    level = 1;
    maxFruits = 3;
    possibleFruits = 1;
    possibleMovments = 0;
  }

}