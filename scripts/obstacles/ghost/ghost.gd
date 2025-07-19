class_name Ghost extends CharacterBody2D

@export var speed := 50.0
@export var chase_speed := 80.0
@export var move_interval := 1.0

@export var activation_distance := 300.0
@export var chase_distance := 100.0
@export var player: CharacterBody2D  

var move_direction := Vector2.ZERO
var move_timer := 0.0

func _ready():
	pick_random_direction()

func _physics_process(delta):
	if player == null:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player <= chase_distance:
		move_direction = global_position.direction_to(player.global_position)
		velocity = move_direction * chase_speed

	elif distance_to_player <= activation_distance:
		move_timer -= delta
		if move_timer <= 0 or velocity.length() > speed:
			pick_random_direction()
		
		velocity = move_direction * speed
		var next_position = global_position + velocity * delta
		if not get_viewport_rect().has_point(next_position):
			pick_random_direction()
			velocity = move_direction * speed			
	else:
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

func _on_collision_detector_body_entered(body):
	if body is Player:
		print("Player touched ghost") 
		get_tree().paused = true
		get_tree().root.get_node("Playground").show_game_over() 
