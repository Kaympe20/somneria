extends Node

signal returnToReality();
signal loadLevel(levelIdentifier: Variant);
signal gameStart();
signal newDialouge(character: String, dialouge: String);
signal updateDialouge(dialouge: String);
signal newBattle(backgroundName: String, enemies: Array[Enemy]);
signal playerAbsurdityCheck();
signal absurdityLevel(callback: Callable);
