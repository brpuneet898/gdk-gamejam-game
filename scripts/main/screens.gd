extends CanvasLayer

@onready var game_over_screen = get_node("GameOverScreen")
@onready var game_win_screen = get_node("GameWinScreen")
@onready var main_menu_screen = get_node("Main Menu")

func _ready():
	if GameState.result == "win":
		game_win_screen.visible = true
		game_over_screen.visible = false
		main_menu_screen.visible = false
	elif GameState.result == "lose":
		game_win_screen.visible = false
		game_over_screen.visible = true
		main_menu_screen.visible = false
	else:
		game_win_screen.visible = false
		game_over_screen.visible = false
		main_menu_screen.visible = true

func _on_quit_pressed():
	get_tree().quit()

func _on_restart_pressed():
	main_menu_screen.visible = false
	GameState.result = ""
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	
func _on_main_menu_pressed():
	GameState.result = ""
	game_win_screen.visible = false
	game_over_screen.visible = false
	main_menu_screen.visible = true
	# Do NOT access UI nodes after this point


func _on_start_pressed():
	main_menu_screen.visible = false
	GameState.result = ""
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
