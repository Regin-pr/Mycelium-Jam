extends Node

var words = ["Meade", "Eugenia", "high school", "remember", "the café", "hi", 
			"I", "choom", "worried about you"]
var eugenia_likes = ["Eugenia", "high school", "remember", "choom"]
var yeo_ji_likes = ["the café"]
var chrys_likes = ["hi"]
var ayanda_likes = ["understand", "language"]

var characters_liked_words

# 5 words, two have to be to her liking to get max points (10)
# ___ ___ ___ ___ ___
# hi  Eugenia  I  remember  high school     :)
# worried about you  the cafe  hi  high school  Meade    :(
# worried about you  the cafe  hi  high school  choom    :)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hard-coded character preferences, is referenced when a word scramble menu is opened
	characters_liked_words = [eugenia_likes, yeo_ji_likes, chrys_likes, ayanda_likes]

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
