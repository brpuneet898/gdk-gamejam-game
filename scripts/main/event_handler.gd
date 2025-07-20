extends Node

@onready var game_over_screen = get_tree().root.get_node("Playground/CanvasLayer/GameOverScreen")
@onready var props_tilemap = get_tree().root.get_node("Playground/Props") # Adjust path if needed
@onready var exit_indicator = get_tree().root.get_node("Playground/ExitIndicator") # Adjust name if needed
@onready var key = get_tree().root.get_node("Playground/Key2")
@onready var exit_condition = false

func show_game_over():
	print("Game Over Triggered")
	print(game_over_screen) 
	game_over_screen.visible = true
	
func _ready():
	key.connect("key_collected", Callable(self, "_on_key_collected"))
	
func _on_key_collected():
	exit_indicator.visible = true
	exit_condition = true
	print(exit_condition)
