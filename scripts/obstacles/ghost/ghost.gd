class_name Ghost extends CharacterBody2D

@export var speed := 50.0
@export var chase_speed := 80.0
@export var move_interval := 1.0

@export var activation_distance := 300.0
@export var chase_distance := 100.0
@export var player: CharacterBody2D  # Assign this in the editor

var move_direction := Vector2.ZERO
var move_timer := 0.0

# The move_range and origin_position variables are removed as they are no longer needed.

func _ready():
	# Start by picking an initial direction.
	pick_random_direction()

func _physics_process(delta):
	if player == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var distance_to_player = global_position.distance_to(player.global_position)

	# State machine, checks from most urgent (chase) to least urgent (idle).
	if distance_to_player <= chase_distance:
		# --- CHASE STATE ---
		# Ghost is close, so it moves directly towards the player at high speed.
		move_direction = global_position.direction_to(player.global_position)
		velocity = move_direction * chase_speed

	elif distance_to_player <= activation_distance:
		# --- WANDER STATE ---
		# Ghost is in range, but not too close. It moves randomly.
		move_timer -= delta
		
		# Pick a new direction if the timer runs out OR if we just stopped chasing.
		# The check 'velocity.length() > speed' correctly detects the switch from
		# high-speed chasing to slower wandering.
		if move_timer <= 0 or velocity.length() > speed:
			pick_random_direction()
		
		velocity = move_direction * speed

		# Check screen boundaries to prevent the ghost from leaving.
		var next_position = global_position + velocity * delta
		if not get_viewport_rect().has_point(next_position):
			pick_random_direction()
			# Immediately apply new direction to avoid getting stuck on the edge
			velocity = move_direction * speed
			
	else:
		# --- IDLE STATE ---
		# Player is too far away. The ghost stops moving.
		velocity = Vector2.ZERO

	move_and_slide()


func pick_random_direction():
	move_timer = move_interval
	var directions = [
		Vector2.RIGHT,
		Vector2.LEFT,
		Vector2.UP,
		Vector2.DOWN
	]
	move_direction = directions[randi() % directions.size()]
