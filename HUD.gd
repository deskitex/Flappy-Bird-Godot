extends Control

@onready var label_score = $Label_Score
@onready var label_highscore = $Label_HighScore
@onready var viewport = get_viewport().size
@onready var label_fps: Label = $Label_FPS
@onready var hud: Control = $"."

var score = 0
var highscore = 0


func _ready():
	#label_score.size = Vector2(viewport.x, 100)
	label_fps.text = str(Global.safe_area_top)
	#Global.add_score.connect(add_score)
	#Global.game_over_score.connect(add_score)

func _physics_process(delta):
	label_score.text = str(Global.score)
	label_highscore.text = str("High Score: \n", Global.highscore)
	#label_fps.text = str(Engine.get_frames_per_second())

#func add_score():
	##Global.score += 1
	#if Global.score >= Global.highscore:
		#Global.highscore = Global.score
		

