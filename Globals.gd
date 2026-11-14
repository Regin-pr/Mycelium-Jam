extends Node

func change_name():
	print(Dialogic.VAR.qm_name)
	Dialogic.Text.speaker_identifier = "???"
	

func get_keyword(new_portrait : String):
	return Dialogic.VAR.keyword1
