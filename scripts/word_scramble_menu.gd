extends Control
class_name WordScrambleMenu

var words_available : Dictionary

func _ready() -> void:
	for word in Vocab.words:
		var kb = preload("res://scenes/keyword_button.tscn").instantiate()
		%KeywordList.add_child(kb)
		kb.text = word
		words_available[word] = kb
