extends KinematicBody2D

const moveSpeed = 100
const maxSpeed = 150

const jumpHeight = -250
const up = Vector2(0,-1)
const gravity = 15

onready var idle = $Idle
onready var walk = $Walk
onready var collision = $CollisionShape2D
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()

func _physics_process(delta):
	
	motion.y += gravity
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		idle.visible = false
		walk.visible = true
		idle.flip_h = false
		walk.flip_h = false
		collision.position.x = -5
		animationPlayer.play("Walk")
		motion.x = min(motion.x + moveSpeed, maxSpeed)
	
	elif Input.is_action_pressed("ui_left"):
		idle.visible = false
		walk.visible = true
		idle.flip_h = true
		walk.flip_h = true
		collision.position.x = 5
		animationPlayer.play("Walk")
		motion.x = max(motion.x - moveSpeed, -maxSpeed)
	
	else:
		idle.visible = true
		walk.visible = false
		animationPlayer.play("Idle")
		friction = true
	
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			motion.y = jumpHeight
			
		if friction == true:
			motion.x = lerp(motion.x,0,0.5)
			
	else:
		if friction == true:
			motion.x = lerp(motion.x,0,0.01)
			
	motion = move_and_slide(motion,up)
	
