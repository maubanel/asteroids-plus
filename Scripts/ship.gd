extends CharacterBody2D

@export var acceleration := 100.0
@export var rotation_speed := 90
@export var max_speed := 450
@export var friction := .99

signal bullet_shot(bullets)

@onready var muzzle = $Muzzle

var bullets_scene = preload ("res://Scenes/bullets.tscn")

var shoot_cd = false
var rate_of_fire = .25

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot_bullet()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false

func _physics_process(delta):
	var input_vector := Vector2(0, Input.get_axis("move_forward", "move_backward"));
	velocity += input_vector.rotated(rotation) * acceleration * delta;
	
	# clamp max speed
	velocity = velocity.limit_length(max_speed)
	
	#friction
	if input_vector.y == 0:
		velocity *=  friction
		
	# Rotation
	if Input.is_action_pressed("rotate_clockwise"):
		rotate(deg_to_rad(rotation_speed * delta))
		
	elif Input.is_action_pressed("rotate_counter_clockwise"):
		rotate(deg_to_rad(-rotation_speed * delta))

	move_and_slide();
	#Get view port size
	var screen_size = get_viewport_rect().size
	
	# Get ship sprite size
	var sprite = $Sprite2D
	var ship_size = sprite.texture.get_size() * .5

	
	# keep player on screen
	if global_position.y < -ship_size.y:
		global_position.y = screen_size.y + ship_size.y
		
	elif global_position.y >  screen_size.y + ship_size.y:
		global_position.y = -ship_size.y
		
	if global_position.x < -ship_size.x:
		global_position.x = screen_size.x + ship_size.x
		
	elif global_position.x >  screen_size.x + ship_size.x:
		global_position.x = -ship_size.x
		
	

func shoot_bullet():
	var bullet = bullets_scene.instantiate()
	bullet.global_position = muzzle.global_position
	bullet.rotation = rotation
	emit_signal("bullet_shot", bullet) 
