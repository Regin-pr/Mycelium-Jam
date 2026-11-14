extends Node

var words = ["Meade", "Eugenia", "high school", "remember", "the café", "hi", 
			"I", "choom", "worried about you"]
var eugenia_likes = ["Eugenia", "high school", "remember", "choom"]

# 5 words, two have to be to her liking to get max points (10)
# ___ ___ ___ ___ ___
# hi  Eugenia  I  remember  high school     :)
# worried about you  the cafe  hi  high school  Meade    :(
# worried about you  the cafe  hi  high school  choom    :)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
