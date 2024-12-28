extends Area2D
class_name EnemyKillBox



func _on_body_entered(body: Node2D) -> void:
	if body is PlayerCharacter2D:
		body.on_hit()
