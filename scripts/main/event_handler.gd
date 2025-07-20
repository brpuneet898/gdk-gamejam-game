extends Node

@onready var game_over_screen = get_tree().root.get_node("Playground/Screens/GameOverScreen")
@onready var game_win_screen = get_tree().root.get_node("Playground/Screens/GameWinScreen")
@onready var props_tilemap = get_tree().root.get_node("Playground/Props")
@onready var exit_indicator = get_tree().root.get_node("Playground/ExitIndicator")
@onready var key = get_tree().root.get_node("Playground/Key2")

@onready var gameplay_music = get_node("GameplayMusic")
@onready var chase_music = get_node("ChaseMusic")
@onready var gameover_music = get_node("GameOverMusic")

@onready var audio_players := [gameplay_music, chase_music, gameover_music]

@export var exit_condition := false
var result = ""

func _ready():
	get_tree().paused = false
	key.connect("key_collected", Callable(self, "_on_key_collected"))
	play_gameplay_music()

func _on_key_collected():
	exit_indicator.visible = true
	exit_condition = true
	print("Key collected, exit enabled:", exit_condition)

func show_game_over():
	print("Game Over Triggered")
	GameState.result = "lose"
	play_gameover_music()
	get_tree().change_scene_to_file("res://assets/Items/Screens.tscn")

func show_game_win():
	print("Game Win Triggered")
	GameState.result = "win"
	stop_all_music()
	get_tree().change_scene_to_file("res://assets/Items/Screens.tscn")

# --- MUSIC CONTROL FUNCTIONS ---

func stop_all_music():
	for audio in audio_players:
		if audio.playing:
			audio.stop()

func play_gameplay_music():
	if chase_music.playing:
		chase_music.stop()
	if gameover_music.playing:
		gameover_music.stop()
	if not gameplay_music.playing:
		gameplay_music.play()

func play_chase_music():
	if gameplay_music.playing:
		gameplay_music.stop()
	if gameover_music.playing:
		gameover_music.stop()
	if not chase_music.playing:
		chase_music.play()

func play_gameover_music():
	if gameplay_music.playing:
		gameplay_music.stop()
	if chase_music.playing:
		chase_music.stop()
	if not gameover_music.playing:
		gameover_music.play()
