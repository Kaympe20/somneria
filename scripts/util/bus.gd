extends Node

signal returnToReality();
signal loadLevel(levelIdentifier: Variant);
signal gameStart();
signal newDialouge(character: String, dialouge: String);
signal updateDialouge(dialouge: String);
signal newBattle(backgroundName: String, enemyNames: Array[String]);
