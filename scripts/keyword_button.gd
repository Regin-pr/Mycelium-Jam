extends Button
class_name KeywordButton

var already_in_use = false

func _init(keyword : String) -> void:
	text = keyword

func _on_pressed() -> void:
	if !already_in_use:
		# grey out
		already_in_use
func reset():
	pass
