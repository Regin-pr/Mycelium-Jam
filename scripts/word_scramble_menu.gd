extends Control
class_name WordScrambleMenu

var words_available : Dictionary
var final_sentence = ""
var default_text = "                 "

var chunk_amount = 5
var chunk_buttons : Array

func _ready() -> void:
	instantiate_available_keyword_buttons()
	instantiate_sentence_chunk_buttons()

func instantiate_available_keyword_buttons():
	for word in Vocab.words:
		var kb : KeywordButton = preload("res://scenes/keyword_button.tscn").instantiate()
		%KeywordList.add_child(kb)
		
		kb.set_keyword(word)
		kb.button.pressed.connect(_on_keyword_button_pressed.bind(kb))
		words_available[word] = kb

func instantiate_sentence_chunk_buttons():
	for chunk in chunk_amount:
		var cb : KeywordButton = preload("res://scenes/keyword_button.tscn").instantiate()
		%SentenceContainer.add_child(cb)
		
		cb.button.flat = true
		cb.set_larger_font_size(54)
		cb.set_chunkword(default_text)
		cb.button.pressed.connect(_on_chunkword_button_pressed.bind(cb))
		
		chunk_buttons = %SentenceContainer.get_children()
		
func _on_keyword_button_pressed(kb : KeywordButton):
	if !kb.button.flat: # Used as indicator if already used in Sentence
		for butt in chunk_buttons:
			if butt.get_keyword() == default_text:
				butt.set_chunkword(kb.get_keyword())
				kb.button.flat = true
				break

func _on_chunkword_button_pressed(cb : KeywordButton):
	words_available[cb.get_keyword()].button.flat = false # Resets the originally pressed button's availability
	cb.set_chunkword(default_text)

func _on_submit_button_pressed() -> void:
	if check_sentence_completed():
		queue_free()
	else:
		print("Sentence not fully formed yet!")
	
func check_sentence_completed() -> bool:
	for button in chunk_buttons:
		if button.get_keyword() == default_text:
			final_sentence = ""
			return false # WRONG!!! Try again
			
		#for word in Vocab.eugenia_likes:
			#if word == button.text:
				## add 5 points
		final_sentence += button.text # If valid
	return true # Yay

func _on_reset_button_pressed() -> void:
	for word in words_available.values():
		word.button.flat = false
	for button in chunk_buttons:
		button.set_chunkword(default_text)
