extends Control
class_name WordScrambleMenu

var words_available : Dictionary
var final_sentence = ""
var default_text = "_____"

var chunk_amount = 5
var chunk_buttons : Array

func _ready() -> void:
	initiate_available_keyword_buttons()
	initiate_sentence_chunk_buttons()


func initiate_available_keyword_buttons():
	for word in Vocab.words:
		var kb = preload("res://scenes/keyword_button.tscn").instantiate()
		%KeywordList.add_child(kb)
		kb.text = word
		kb.pressed.connect(_on_keyword_button_pressed.bind(kb))
		words_available[word] = kb

func initiate_sentence_chunk_buttons():
	for chunk in chunk_amount:
		var cb = preload("res://scenes/keyword_button_large.tscn").instantiate()
		%SentenceContainer.add_child(cb)
		cb.text = default_text
		cb.pressed.connect(_on_chunkword_button_pressed.bind(cb))
		
		chunk_buttons = %SentenceContainer.get_children()
		
func _on_keyword_button_pressed(kb : Button):
	print("pressed")
	if !kb.flat: # Used as indicator if already used in Sentence
		print("and not flat")
		for butt in chunk_buttons:
			if butt.text == default_text:
				print("AND default text")
				butt.text = kb.text
				kb.flat = true
				break

func _on_chunkword_button_pressed(cb : Button):
	words_available[cb.text].flat = false # Resets the originally pressed button's availability
	cb.text = default_text
	

func _on_submit_button_pressed() -> void:
	if check_sentence_completed():
		queue_free()
	else:
		print("Sentence not fully formed yet!")
	
func check_sentence_completed() -> bool:
	for button in chunk_buttons:
		if button.text == default_text:
			final_sentence = ""
			return false # WRONG!!! Try again
			
		#for word in Vocab.eugenia_likes:
			#if word == button.text:
				## add 5 points
		final_sentence += button.text # If valid
	return true # Yay

func _on_reset_button_pressed() -> void:
	for word in words_available.values():
		word.flat = false
	for button in chunk_buttons:
		button.text = default_text
