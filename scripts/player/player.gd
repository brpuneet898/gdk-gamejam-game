class_name Player extends CharacterBody2D 

var move_speed : float = 100.0
@onready var sprite : Sprite2D = $Sprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var player_light: PointLight2D = $PointLight2D
@onready var playground = get_tree().root.get_node("Playground")
@onready var props_tilemap = playground.get_node("Props")

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
	check_for_win()
	
func update_animation():
	var current_anim = ""
	var light_offset = Vector2(0, 0)

	if velocity.length() == 0:
		current_anim = "idle_down"
		light_offset = Vector2(-21, -35)
	else:
		if abs(velocity.x) > abs(velocity.y) : 
			if velocity.x > 0 :
				current_anim = "walk_left"
				light_offset = Vector2(21, -35)
			else:
				current_anim = "walk_right"
				light_offset = Vector2(-21, -35)
		else:
			if velocity.y > 0:
				current_anim = "walk_down"
				light_offset = Vector2(-21, -35)
			else:
				current_anim = "walk_up"
				light_offset = Vector2(21, -35)
	if anim_player.current_animation != current_anim:
		anim_player.play(current_anim)
	player_light.position = light_offset

func check_for_win():
	if not playground.exit_condition:
		return

	var tile_coords = props_tilemap.local_to_map(global_position)

	var tile_id = props_tilemap.get_cell_source_id(0, tile_coords)

	if tile_id == -1:
		return

	var tile_data = props_tilemap.get_cell_tile_data(0, tile_coords)
	if tile_data:
		var count = tile_data.get_collision_polygons_count(0)

		if count == 0:
			playground.show_game_win()
	else:
		print("No tile data found.")
