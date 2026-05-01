extends Node;
class_name PlayerData;

static func getMoves(moveType: int) -> Array[move]:
	var moveArray: Array;
	match moveType:
		move.moveTypes.attack: moveArray = getAttacks();
	return convertToMoves(moveArray);
	
# Called when the node enters the scene tree for the first time.
static func getAttacks() -> Array[attack]:
	var currentAttacks: Array[attack] = [attack.new("Big Depleting Attack"), attack.new("Small Eco Attack")];
	
	return currentAttacks;
	
static func getMoveNames(moveArray: Array[move]) -> Array[String]:
	var stringArray: Array[String] = [];
	for currentMove in moveArray:
		stringArray.append(currentMove.getName());
	return stringArray;

static func convertToMoves(nonMoveArray: Array): ## Fixes godot's inallowance of casting from parent to child
	var moveArray: Array[move] = [];
	for move in nonMoveArray:
		moveArray.append(move);
	return moveArray;
