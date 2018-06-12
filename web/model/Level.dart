class Level {
  int level = 1;
  int requiredScore = 0;
  int maxFruits = 3;
  int maxBombs = 1;
  int possibleFruits = 1;
  int possibleBombs = 1;
  int possibleMovments = 0;

  Level(this.level, this.requiredScore, this.maxFruits, this.possibleFruits, this.possibleMovments);

  void reset() {
    level = 1;
    requiredScore = 0;
    maxFruits = 3;
    maxBombs = 1;
    possibleFruits = 1;
    possibleMovments = 0;
  }

  String toString() {
    return '{Lvl: ' + level.toString() + ' | mF: ' + maxFruits.toString() + ' | rS: ' + requiredScore.toString() + '}';
  }

}