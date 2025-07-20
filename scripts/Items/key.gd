extends Area2D

signal key_collected

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("key_collected")
		queue_free()  # This removes the key after pickup
