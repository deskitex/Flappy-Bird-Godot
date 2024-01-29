extends Node2D

@onready var bg = $BG
@onready var viewport = get_viewport_rect().size
@onready var player = $Player
@onready var ground = $Ground
@onready var ground_texture = $Ground/TextureRect
@onready var ground_collision = $Ground/CollisionShape2D
@onready var ground_collider_collision = $Ground/Collider/CollisionShape2D
@onready var timer = $Timer
@onready var level_spawner_group = $Level_spawner_group
@onready var hud: Control = $HUD
@onready var bg_down: TextureRect = $bgDown

#@onready var label_score = hud_scene.get_child(0)
#@onready var label_highscore = hud_scene.get_child(1)

@onready var menu_layer = $MenuLayer
var level_spawner_scene = preload("res://Scene/level_spawner.tscn")

var bg_move = 0
var ground_move = 0
var game_started = false
var pause_game_var = false
var ground_size_y = 168


func _ready():
	bg.size.x = bg.get_texture().get_width() * 2
	#bg.global_position.y = viewport.y - bg.get_texture().get_height()-ground_size_y
	bg.global_position = Vector2(0,0)
	#bg_down.global_position.y = -bg_up.get_texture().get_height() - bg.global_position.y
	bg_down.global_position =Vector2(0, bg.get_texture().get_height() - 10)
	
	player.jump_signal.connect(start)
	if Global.os_name == "Android" || "Window":
		hud.global_position.y = 0+Global.safe_area_top/2
	#player.new_score.connect(score_add)
	#Global.pause_game.connect(pause_game)
	player_spawn()
	ground_position()
	timer.stop()
	Global.load_score()
	#menu_layer.global_position = Vector2(0,0)
	

func _physics_process(delta):
	bg.global_position.x -= bg_move
	if bg.global_position.x <= -viewport.x:
		bg.global_position.x = 0
	ground_texture.global_position.x -= ground_move
	if ground_texture.global_position.x <= -180:
		ground_texture.global_position.x = 0

func start():
	if game_started: return
	game_started = true
	timer.start()
	bg_move = 1
	ground_move = 6
	menu_layer.game_started()
	spawn_level()
	
func player_spawn():
	player.global_position = Vector2(100, viewport.y/2)
	
func ground_position():
	var ground_size_x = 504
	
	ground.global_position = Vector2(0, 0)
	
	ground_collision.global_position = Vector2(viewport.x/2, ground_size_y/2-1 )
	ground_collision.shape = RectangleShape2D.new()
	ground_collision.shape.size = Vector2(viewport.x, ground_size_y)
	ground_collider_collision.global_position = Vector2(viewport.x/2, ground_size_y/2)
	
	ground_collider_collision.shape = RectangleShape2D.new()
	ground_collider_collision.shape.size = Vector2(viewport.x, ground_size_y)
	#ground.global_position = Vector2(0, viewport.y-ground_size_y-Global.safe_area_top)
	ground.global_position = Vector2(0, viewport.y-ground_size_y)
	
	
	ground_texture.size.x = viewport.x + 180

func _on_timer_timeout():
	spawn_level()
	
func spawn_level():
	if pause_game_var ==false:
		var level_spawner = level_spawner_scene.instantiate()
		level_spawner_group.add_child(level_spawner)

#func score_add():
	#hud_scene.add_score(1)
func _on_ground_body_entered(body):
	if body is Player:
		body.die()
		
#func pause_game():
	#if pause_game_var == true: return
	#pause_game_var = true
	#set_physics_process(false)
	#timer.stop()
	

