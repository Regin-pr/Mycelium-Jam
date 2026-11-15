extends MarginContainer
class_name KeywordButton

@onready var button : Button = %KeywordButton
@onready var label : RichTextLabel = %Label

func get_keyword() -> String:
	var keyword : String = label.text
	keyword = keyword.trim_prefix("[u][i]   ")
	keyword = keyword.trim_suffix("   [/i][/u]")
	return keyword

func set_keyword(new_text : String):
	label.text = new_text

func set_chunkword(new_text : String):
	label.text = "[u][i]   " + new_text + "   [/i][/u]"


func set_larger_font_size(size : int):
	label.add_theme_font_size_override("font_size", size)
	label.add_theme_font_size_override("bold_font_size", size)


# do default text stuff here instead of in the menu maybe
