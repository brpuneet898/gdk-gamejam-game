extends Node

@onready var game_over_screen = get_tree().root.get_node("Playground/Screens/GameOverScreen")
@onready var game_win_screen = get_tree().root.get_node("Playground/Screens/GameWinScreen")
@onready var props_tilemap = get_tree().root.get_node("Playground/Props") # Adjust path if needed
@onready var exit_indicator = get_tree().root.get_node("Playground/ExitIndicator") # Adjust name if needed
@onready var key = get_tree().root.get_node("Playground/Key2")
@onready var exit_condition = false
var result = ""

func show_game_over():
	print("Game Over Triggered")
	print(game_over_screen)
	GameState.result = "lose"
	get_tree().change_scene_to_file("res://assets/Items/Screens.tscn")
	
func show_game_win():
	print("Game Win Triggered")
	print(game_win_screen)
	GameState.result = "win"
	get_tree().change_scene_to_file("res://assets/Items/Screens.tscn")
	
func _ready():
	get_tree().paused = false
	key.connect("key_collected", Callable(self, "_on_key_collected"))
	
func _on_key_collected():
	exit_indicator.visible = true
	exit_condition = true
	print(exit_condition)
