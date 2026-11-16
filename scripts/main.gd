extends Control

@onready var anim = $AnimationPlayer

var steals_for_the_day = 4

var stealbutton1 : KeywordButton
var stealbutton2 : KeywordButton
var stealbutton3 : KeywordButton

var stealword_button_array : Array

var focusing_steal_area = false

func _ready() -> void:
	Dialogic.signal_event.connect(receive_signal)
	update_uses_label()
	instantiate_steal_buttons()

func _input(event: InputEvent):
	if event.is_action_pressed("hide"):
		if %StealPopup.visible:
			%StealButton.button_pressed = false # Calls Toggle Func
		elif Dialogic.Text.is_textbox_visible():
			Dialogic.Text.hide_textbox()
		else:
			Dialogic.Text.show_textbox()

	if event.is_action_pressed("close_popup"):
		if %StealPopup.visible and !focusing_steal_area:
			%StealButton.button_pressed = false # Calls Toggle Func
	
	# check if a dialog is already running
	if Dialogic.current_timeline != null:
		return

func _process(delta: float) -> void:
	if Input.is_action_pressed("skip"):
		print("skipping")
		Input.action_press("text_advance", 1.0) # Simulates a text advance every frame

func _on_steal_button_toggled(toggled_on: bool) -> void:
	print("Calls toggle")
	if toggled_on:
		%StealPopup.visible = true
		%StealButton.queue_redraw()
		
		for index in stealword_button_array.size():
			var b = stealword_button_array[index]
			if Vocab.stealword_queue[index] != "":
				b.set_keyword(Vocab.stealword_queue[index])
				b.visible = true
			else:
				b.visible = false
	else:
		close_steal_popup()

func _on_stealword_button_pressed(sb : KeywordButton):
	if steals_for_the_day > 0:
		Vocab.words.append(sb.get_keyword())
		sb.visible = false
		
		Vocab.update_stealword_queue(stealword_button_array.find(sb))

## "ADDED TO VOCAB YAAAAY!!!"

		steals_for_the_day -= 1
		update_uses_label()

func receive_signal(argument : String):
	match argument:
		"steal_appear":
			%StealButton.visible = true
		"scramble":
			Dialogic.Text.hide_textbox()
			Dialogic.paused = true
			var sc = preload("res://scenes/word_scramble_menu.tscn").instantiate()
			%Canvas.add_child(sc)
		"next_scene":
			Globals.day += 1
			%DayLabel.text = "Day " + Globals.day
			anim.play("show_day")
			
			# Call start from array of consecutive scenes instead of static
			
			steals_for_the_day = 4
			update_uses_label()
		"scene_1_trans":
			advance_next_day()
			
			Dialogic.start('day_1')
			get_viewport().set_input_as_handled() 
		"scene_2_trans":
			advance_next_day()
			Vocab.words.append("work")

			Dialogic.start('day_2')
			get_viewport().set_input_as_handled()
		"scene_3_trans":
			advance_next_day()

			Dialogic.start('day_3')
			get_viewport().set_input_as_handled()
		"scene_4_trans":
			advance_next_day()

			Dialogic.start('day_4')
			get_viewport().set_input_as_handled()

func advance_next_day():
	Globals.day += 1
	%DayLabel.text = "Day " + str(Globals.day)
	anim.play("show_day")
	
	# Call start from array of consecutive scenes instead of static
	
	Vocab.empty_steal_queue()
	steals_for_the_day = 4
	update_uses_label()

func update_uses_label():
	%UsesLabel.text= "Words left for today: " + str(steals_for_the_day)

func _on_video_stream_player_finished() -> void:
	$VideoCanvas/VideoStreamPlayer.queue_free()
	Dialogic.start('day_0')
	get_viewport().set_input_as_handled() 

func instantiate_steal_buttons():
	stealbutton1 = preload("res://scenes/keyword_button.tscn").instantiate()
	%WordContainer.add_child(stealbutton1)
		
	stealbutton2 = preload("res://scenes/keyword_button.tscn").instantiate()
	%WordContainer.add_child(stealbutton2)
		
	stealbutton3 = preload("res://scenes/keyword_button.tscn").instantiate()
	%WordContainer.add_child(stealbutton3)

	stealbutton1.button.pressed.connect(_on_stealword_button_pressed.bind(stealbutton1))
	stealbutton2.button.pressed.connect(_on_stealword_button_pressed.bind(stealbutton2))
	stealbutton3.button.pressed.connect(_on_stealword_button_pressed.bind(stealbutton3))

	stealword_button_array = [stealbutton1, stealbutton2, stealbutton3]

func close_steal_popup():
	%StealPopup.visible = false
	focusing_steal_area = false

func _on_steal_area_mouse_entered() -> void:
	focusing_steal_area = true
	print("entered")

func _on_steal_area_mouse_exited() -> void:
	focusing_steal_area = false
	print("exited")
