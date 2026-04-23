extends Area2D

@export var speed := 500.0
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:

var movement_vector := Vector2(0, -1)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta;
	


#func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
#	print ("deleting bullet")
	#queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#print ("Bullet" + name)
	#delete object
	queue_free()
