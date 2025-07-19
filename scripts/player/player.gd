
class_name Player extends CharacterBody2D 

var move_speed : float = 100.0
@onready var sprite : Sprite2D = $Sprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	pass

func _process( delta ):
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = direction * move_speed

func _physics_process( delta ):
	update_animation()
	move_and_slide()
	
	
func update_animation():
	var current_anim = ""

	if velocity.length() == 0:
		current_anim = "idle_down"
	else:
		if abs(velocity.x) > abs(velocity.y):
			sprite.flip_h = true
			if velocity.x > 0 :
				current_anim = "walk_left"
			else:
				current_anim = "walk_right" 
		else:
			sprite.flip_h = false
			if velocity.y > 0:
				current_anim = "walk_down"
			else:
				current_anim = "walk_up"
	if anim_player.current_animation != current_anim:
		anim_player.play(current_anim)
