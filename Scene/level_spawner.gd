extends Node2D
signal score_add
@onready var viewport = get_viewport_rect().size
@onready var point: AudioStreamPlayer2D = $Point

func _ready():
	global_position.x = viewport.x + 200
	global_position.y = randf_range(0, -240)
	#Global.pause_game.connect(pause_game)
	
func _physics_process(delta):
	global_position.x -= 5

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func _on_area_score_body_entered(body):
	if body is Player:
		add_score()
		point.play()

func _on_pipe_down_body_entered(body):
	if body is Player:
		body.die()

func _on_pipe_up_body_entered(body):
	if body is Player:
		body.die()
		
#func pause_game():
	#set_physics_process(false)
func add_score():
	Global.score += 1
	if Global.score >= Global.highscore:
		Global.highscore = Global.score
