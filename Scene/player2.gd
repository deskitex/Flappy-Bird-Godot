extends CharacterBody2D
class_name Players 
signal new_score
signal pause_game
@onready var animator = $AnimationPlayer
var gravity = 0
var rotate_gravity:float = 0
var alive = true

signal jump_signal
func _ready():
	animator.play("Idle")

func _unhandled_input(event):
	jump()
	
func _physics_process(delta):
	velocity.y += gravity
	if alive:
		rotation_degrees += rotate_gravity
	
	if velocity.y >= 1000:
		velocity.y = 1000
		
	if rotation_degrees >= 90:
		rotation_degrees = 90
	elif  rotation_degrees <= -45:
		rotation_degrees = -45
		
	if global_position.y <= 0:
		global_position.y = 0
	
	move_and_slide()
func jump():
	if Input.is_action_just_pressed("flap") && alive:
		animator.play("Flap")
		gravity = 30
		velocity.y = -500
		rotate_gravity = 1.4
		rotation_degrees -= 50
		jump_signal.emit()
	
func score_add():
	new_score.emit()
	
func die():
	if !alive: return
	alive = false
	animator.stop()
	get_tree().call_group("pause", "set_physics_process", false)
	get_tree().call_group("pause", "stop")
	
	#Global.pause_game.emit()
