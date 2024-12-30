extends Node

var player: PlayerCharacter2D

func accept_player(new_player: PlayerCharacter2D) -> void:
	if new_player:
		player = new_player

func get_player_pos() -> Vector2:
	if not player:
		return Vector2.ZERO
	else:
		return player.global_position
