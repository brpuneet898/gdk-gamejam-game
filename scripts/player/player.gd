
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
	
	#if direction.length() > 0:
		#if abs(direction.x) > abs(direction.y):
			#sprite.frame = 8 if direction.x > 0 else 12
		#else:
			#sprite.frame = 4 if direction.y > 0 else 0
	#pass

func _physics_process( delta ):
	update_animation()
	move_and_slide()
	
	
func update_animation():
	var current_anim = "" # A variable to hold the name of the animation we want to play

	if velocity.length() == 0:
		# Player is still, play an idle animation
		# You can add more complex idle logic here (e.g., idle_up, idle_down)
		current_anim = "idle_down"
	else:
		# Player is moving, determine direction
		if abs(velocity.x) > abs(velocity.y):
			sprite.flip_h = true
			# Moving more horizontally than vertically
			if velocity.x > 0 :
				current_anim = "walk_left"
			# Flip the sprite based on direction
			else:
				current_anim = "walk_right" # Flip horizontally if moving left
		else:
			# Moving more vertically than horizontally
			sprite.flip_h = false
			if velocity.y > 0:
				current_anim = "walk_down"
			else:
				current_anim = "walk_up"
	if anim_player.current_animation != current_anim:
		anim_player.play(current_anim)
