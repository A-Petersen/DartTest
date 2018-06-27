class Level {
  int level = 1;
  int requiredScore = 0;
  int maxFruits = 3;
  int bombChance = 0;
  int smoothieChance = 0;
  int heartChance = 0;
  int possibleFruits = 1;
  int possibleBombs = 1;
  int possibleMovments = 0;

  Level(this.level, this.requiredScore, this.maxFruits, this.bombChance, this.smoothieChance, this.heartChance, this.possibleFruits, this.possibleMovments);


  String toString() {
    return '{Lvl: ' + level.toString() + ' | mF: ' + maxFruits.toString() + ' | rS: ' + requiredScore.toString() + '}';
  }

}