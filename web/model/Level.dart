/**
 * Die Klasse Level beschreibt, was auf dem Spielfeld passieren soll,
 * ab wann Limitierung erhöht oder gesenkt werden sollen
 * und mit welcher Wahrscheinlichkeit etwas passieren kann.
 */
class Level {
  /**
   * Level-Nummer
   */
  int level = 1;

  /**
   * Benötigter Score für das Level
   */
  int requiredScore = 0;

  /**
   * Maximale Anzahl an Früchten auf den Spielfeld
   */
  int maxFruits = 3;

  /**
   * Wahrscheinlichkeit für Bomben
   */
  int bombChance = 0;

  /**
   * Wahrscheinlichkeit für Smoothies
   */
  int smoothieChance = 0;

  /**
   * Wahrscheinlichkeit für Herzen
   */
  int heartChance = 0;

  /**
   * Mögliche Früchte die Auftauchen können
   */
  int possibleFruits = 1;

  /**
   * Mögliche Bomben, die auftauchen können
   */
  int possibleBombs = 1;

  /**
   * Mögliche Bewegungen, die ein UFO haben kann
   */
  int possibleMovments = 0;

  Level(this.level, this.requiredScore, this.maxFruits, this.bombChance, this.smoothieChance, this.heartChance, this.possibleFruits, this.possibleMovments);

  /**
   * Setzt das Level zurück auf das Anfangs-Level
   */
  void reset() {
    level = 1;
    requiredScore = 0;
    maxFruits = 3;
    bombChance = 0;
    smoothieChance = 0;
    heartChance = 0;
    possibleFruits = 1;
    possibleMovments = 0;
  }
  
  String toString() {
    return '{Lvl: ' + level.toString() + ' | mF: ' + maxFruits.toString() + ' | rS: ' + requiredScore.toString() + '}';
  }

}