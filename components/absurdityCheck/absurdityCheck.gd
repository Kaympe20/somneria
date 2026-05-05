extends Control

var timeElapsed: float;
var gameActive: bool = false;
var absurdity: float = 0.8;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeElapsed = PlayerData.getElapsedTime();
	
	Bus.playerAbsurdityCheck.connect(sendAbsurdity);
	
	Bus.playerAbsurdityCheck.emit();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gameActive:
		timeElapsed += delta;

func _on_start_pressed() -> void:
	gameActive = true;

func calcAbsurdityFromTime():
	absurdity -= 0.012 * (log(1.001)/log(timeElapsed));

	timeElapsed = 0;

	print(absurdity);

func sendAbsurdity(callback: Callable) -> float:
	calcAbsurdityFromTime();
	
	callback.call(absurdity);
	return absurdity;
