extends Control

func _ready() -> void:
	Dialogic.signal_event.connect(receive_signal)

func _input(event: InputEvent):
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return

	if event is InputEventKey and event.keycode == KEY_ENTER and event.pressed:
		Dialogic.start('day_1')
		get_viewport().set_input_as_handled() 

func _on_steal_button_toggled(toggled_on: bool) -> void:
	if !toggled_on:
		pass

func receive_signal(argument : String):
	match argument:
		"scramble_01":
			var sc01 = preload("res://scenes/word_scramble_menu.tscn").instantiate()
			%Canvas.add_child(sc01)
