extends Node
class_name root

var frameCount: int = 0;

enum views {
	firstPerson,
	thirdPerson,
	battle
}

func activeView() -> int:
	var playerNodeArray: Array[Node] = get_tree().get_nodes_in_group("Player") as Array[Node];
	
	if playerNodeArray.size() == 0:
		return views.battle;
	elif playerNodeArray[0].firstPerson:
		return views.firstPerson;
	else:
		return views.thirdPerson;
		
func _process(delta: float) -> void:
	frameCount += 1;
	
	if frameCount == 10:
		#print(activeView());
		frameCount = 0;
