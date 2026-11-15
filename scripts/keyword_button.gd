extends Button
class_name KeywordButton

#var already_in_use = false
#signal pressed_arg
#
#func _init(keyword : String) -> void:
	#text = keyword
#
#func _on_pressed_arg():
	#pressed.connect(_on_pressed_arg.bind(text))
#
#func _on_pressed() -> void:
	#if !already_in_use:
		#flat = true
		#already_in_use = true
		#
#func reset():
	#already_in_use = false
	#flat = false
