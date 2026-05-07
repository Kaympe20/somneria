## Player Data
##
## This class is mostly hardcoded currently, but in the future it will be used to read from storage
extends Node;
class_name PlayerData;
	
static func getElapsedTime() -> float: ## Gets the saved time from 
	return 0;

# The below four functions are for player movement actions

static func getMoves(moveType: int) -> Array[move]:
	var moveArray: Array;
	match moveType:
		move.moveTypes.attack: moveArray = getAttacks();
	return convertToMoves(moveArray);
	
static func getMoveNames(moveArray: Array[move]) -> Array[String]:
	var stringArray: Array[String] = [];
	for currentMove in moveArray:
		stringArray.append(currentMove.getName());
	return stringArray;

static func convertToMoves(nonMoveArray: Array): ## Fixes godot's inallowance of casting from parent to child
	var moveArray: Array[move] = [];
	for currentMove in nonMoveArray:
		moveArray.append(currentMove);
	return moveArray;
	
static func getAttacks() -> Array[attack]:
	var currentAttacks: Array[attack] = [attack.new("Big Depleting Attack",""), attack.new("Small Eco Attack", "")];
	return currentAttacks;
