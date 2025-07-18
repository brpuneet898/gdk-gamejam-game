class_name Player extends CharacterBody2D 

var move_speed : float = 100.0
@onready var sprite : Sprite2D = $Sprite2D

func _ready():
	pass

func _process( delta ):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = direction * move_speed
	
	if direction.length() > 0:
		if abs(direction.x) > abs(direction.y):
			sprite.frame = 2 if direction.x > 0 else 3
		else:
			sprite.frame = 1 if direction.y > 0 else 0
	pass

func _physics_process( delta ):
	move_and_slide()
