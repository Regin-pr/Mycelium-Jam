extends Node

var words = ["Meade", "Eugenia", "high school"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	words.append("verity")
	pass # Replace with function body.

func append(input: String) -> void:
	words.append(input)

func getWord(i: int) -> String:
	if i >= words.size():
		return ""
	return words[i]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(getWord(0))
	pass
