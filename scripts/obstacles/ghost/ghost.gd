class_name Ghost extends CharacterBody2D

@export var move_range := 100.0      
@export var speed := 50.0         
@export var move_interval := 1.0    

var origin_position := Vector2.ZERO
var move_direction := Vector2.ZERO
var move_timer := 0.0

func _ready():
	origin_position = global_position
	pick_random_direction()

func _physics_process(delta):
	move_timer -= delta
	if move_timer <= 0:
		pick_random_direction()
	var next_position = global_position + move_direction * speed * delta
	if (next_position - origin_position).length() > move_range:
		pick_random_direction()
		return
	var screen_bounds = Rect2(Vector2.ZERO, Vector2(640, 340))
	if not screen_bounds.has_point(next_position):
		pick_random_direction()
		return
	velocity = move_direction * speed
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
