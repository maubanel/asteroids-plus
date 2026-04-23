extends Node2D

@onready var bullets = $Bullets
@onready var ship = $Ship

# Called when the node enters the scene tree for the first time.
func _ready():
	ship.connect("bullet_shot", _on_ship_bullet_shot)


func _on_ship_bullet_shot(bullet):
	bullets.add_child(bullet)
