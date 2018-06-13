class Level {
  int level = 1;
  int requiredScore = 0;
  int maxFruits = 3;
  int bombChance = 0;
  int smoothieChance = 0;
  int possibleFruits = 1;
  int possibleBombs = 1;
  int possibleMovments = 0;

  Level(this.level, this.requiredScore, this.maxFruits, this.bombChance, this.smoothieChance, this.possibleFruits, this.possibleMovments);

  void reset() {
    level = 1;
    requiredScore = 0;
    maxFruits = 3;
    bombChance = 0;
    smoothieChance = 0;
    possibleFruits = 1;
    possibleMovments = 0;
  }

  String toString() {
    return '{Lvl: ' + level.toString() + ' | mF: ' + maxFruits.toString() + ' | rS: ' + requiredScore.toString() + '}';
  }

}