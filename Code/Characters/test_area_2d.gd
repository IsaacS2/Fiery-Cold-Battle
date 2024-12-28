extends Area2D

func _ready() -> void:
	print("Area2D ready")

func _on_body_entered(body: CharacterBody2D) -> void:
	print("Area entered")
