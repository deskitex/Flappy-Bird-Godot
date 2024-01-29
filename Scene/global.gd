extends Node

signal player_die
signal add_score
signal game_over_score

var score:=0
var highscore:=0
const SAVE_PATH = "user://savedata.save"
var os_name = OS.get_name()
var safe_area = DisplayServer.get_display_safe_area()
var safe_area_top = safe_area.position.y
@onready var viewport = get_viewport().size

func save_score():
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(highscore)
	file.close()
	
func load_score():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		highscore = file.get_var()
		file.close()
