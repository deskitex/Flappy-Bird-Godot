extends CanvasLayer
signal game_star
@onready var tween = get_tree().create_tween()
@onready var viewport = get_viewport().size
@onready var texture_rect: TextureRect = $StartMenu/TextureRect
@onready var start_menu: Control = $StartMenu
@onready var score: Label = $GameOverMenu/VBoxContainer/Score
@onready var high_score: Label = $GameOverMenu/VBoxContainer/High_Score
@onready var restart_button: Button = $GameOverMenu/VBoxContainer/Restart_Button
@onready var game_over_menu: Control = $GameOverMenu


var game_start = false

func _ready():
	#start_texture.modulate.a = 1.0
	pass
	tween.stop()
	#start_menu.size = viewport
	game_over_menu.visible = false
	Global.player_die.connect(game_over)
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("flap"):
		
		game_started()
func game_started():
	if game_start: return
	game_start = true
	tween.play()
	
	var tween_disappear = tween.tween_property(start_menu, "modulate:a", 0, 0.5)
	await(tween_disappear.finished)
	start_menu.visible = false
	set_process_input(false)

func _on_restart_button_pressed() -> void:
	Global.score = 0
	get_tree().reload_current_scene()

func game_over():
	game_over_menu.visible = true
	score.text = "Score: " + str(Global.score)
	high_score.text = "Best: "+ str(Global.highscore)
	Global.save_score()
