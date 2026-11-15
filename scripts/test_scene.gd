extends Control

@onready var anim = $AnimationPlayer

var uses_for_the_day = 3

func _ready() -> void:
	Dialogic.signal_event.connect(receive_signal)

func _input(event: InputEvent):
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return

	if event is InputEventKey and event.is_action_pressed("text_advance"):
		Dialogic.start('day_1')
		get_viewport().set_input_as_handled() 
		
		anim.play("show_day")

func _on_steal_button_toggled(toggled_on: bool) -> void:
	if !toggled_on:
		%StealPopup.visible = true
		for keyword in Dialogic.KEYWORDS:
			if keyword != "":
				var sb : KeywordButton = preload("res://scenes/keyword_button.tscn").instantiate()
				%WordContainer.add_child(sb)
			
				sb.set_keyword(keyword)
				sb.button.pressed.connect(_on_stealword_button_pressed.bind(sb))
	else:
		%StealPopup.visible = false

func _on_stealword_button_pressed(sb : KeywordButton):
	if !sb.button.flat:
		Vocab.words.append(sb.get_keyword())
		sb.button.flat = true
		# -1 uses

func receive_signal(argument : String):
	match argument:
		"steal_appear":
			%StealButton.visible = true
		"scramble_01":
			Dialogic.Text.hide_textbox()
			Dialogic.paused = true
			var sc01 = preload("res://scenes/word_scramble_menu.tscn").instantiate()
			%Canvas.add_child(sc01)
		"scene_2_trans":
			Dialogic.start('day_2')
			get_viewport().set_input_as_handled()
		"scene_3_trans":
			Dialogic.start('day_3')
			get_viewport().set_input_as_handled()
		"scene_4_trans":
			Dialogic.start('day_4')
			get_viewport().set_input_as_handled()
