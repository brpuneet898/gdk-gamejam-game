class_name Ghost
extends CharacterBody2D

@onready var tilemap: TileMap = $"../GhostIndicator"   # Adjust path if needed
@onready var effect_area: Area2D = $EffectDetector     # Adjust path if needed

@export var speed := 40.0
@export var chase_speed := 60.0
@export var move_interval := 1.0
@export var activation_distance := 300.0
@export var chase_distance := 100.0
@export var player: CharacterBody2D

var original_tiles := {}

var move_direction := Vector2.ZERO
var move_timer := 0.0

func _ready():
	pick_random_direction()
	# Store all original tiles to restore visibility later
	for cell in tilemap.get_used_cells(0):
		var data = {
			"source_id": tilemap.get_cell_source_id(0, cell),
			"atlas_coords": tilemap.get_cell_atlas_coords(0, cell),
			"alt": tilemap.get_cell_alternative_tile(0, cell)
		}
		original_tiles[cell] = data

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
	_update_tiles_visibility()

func pick_random_direction():
	move_timer = move_interval
	var directions = [
		Vector2.RIGHT,
		Vector2.LEFT,
		Vector2.UP,
		Vector2.DOWN
	]
	move_direction = directions[randi() % directions.size()]

func _on_kill_detector_body_entered(body):
	if body is Player:
		print("Player touched ghost")
		get_tree().paused = true
		get_tree().root.get_node("Playground").show_game_over()

func _update_tiles_visibility():
	var effect_shape = effect_area.get_node("Effect Radius").shape
	var area_pos = effect_area.global_position
	var tile_size = tilemap.tile_set.tile_size

	for cell in original_tiles.keys():
		# Convert Vector2i to Vector2
		var cell_vec2 = Vector2(cell.x, cell.y)
		var world_pos = tilemap.map_to_local(Vector2(cell.x, cell.y)) + Vector2(tile_size.x, tile_size.y) / 2
		var in_radius = false

		if effect_shape is CircleShape2D:
			in_radius = area_pos.distance_to(world_pos) <= effect_shape.radius

		if in_radius:
			var tile = original_tiles[cell]
			tilemap.set_cell(0, cell, tile.source_id, tile.atlas_coords, tile.alt)
		else:
			tilemap.set_cell(0, cell, -1)
