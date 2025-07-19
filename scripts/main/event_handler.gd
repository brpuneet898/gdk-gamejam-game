extends Node

@onready var game_over_screen = get_tree().root.get_node("Playground/CanvasLayer/GameOverScreen")

func show_game_over():
	print("Game Over Triggered")
	print(game_over_screen) 
	game_over_screen.visible = true
