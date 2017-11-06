extends KinematicBody2D

export var speed = Vector2()
var velocity     = Vector2()
var dir          = 0
var to_dir       = 0

const MAX_SPEED    = 300
const ACCELERATION = 600
const DECELERATION = 900
const JUMP_FORCE   = 250
const GRAVITY      = 800

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	
	if Input.is_action_pressed("move_jump"):
		speed.y = -JUMP_FORCE
	
	if   Input.is_action_pressed("move_left"):
		  dir = -1
	elif Input.is_action_pressed("move_right"):
		  dir =  1
	else: dir =  0
	
	if dir != 0:
		  speed.x += ACCELERATION * delta
		  to_dir = dir
	else: speed.x -= DECELERATION * delta
	
	speed.x = clamp(speed.x , 0 , MAX_SPEED)
	
	speed.y += GRAVITY * delta
	
	velocity.x = speed.x * to_dir * delta
	velocity.y = speed.y * delta
	
	move(velocity)
	
	var move_remainder = move(velocity)
	
	if is_colliding():
		if get_collider().is_in_group("ground"):
			var normal = get_collision_normal()
			var final_movement = normal.slide(move_remainder)
			speed.y = 0
			move(final_movement)
	
