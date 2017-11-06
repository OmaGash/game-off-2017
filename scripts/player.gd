extends KinematicBody2D

export var speed = 0
var velocity
var dir    = 0
var to_dir = 0

const MAX_SPEED    = 300
const ACCELERATION = 600
const DECELERATION = 900

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	
	if   Input.is_action_pressed("move_left"):
		  dir = -1
	elif Input.is_action_pressed("move_right"):
		  dir =  1
	else: dir =  0
	
	if dir != 0:
		  speed += ACCELERATION * delta
		  to_dir = dir
	else: speed -= DECELERATION * delta
	
	speed = clamp(speed , 0 , MAX_SPEED)
	velocity = speed * to_dir * delta
	
	move(Vector2(velocity , 0))
