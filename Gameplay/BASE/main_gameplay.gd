extends Node2D
class_name MainGameplayNode2D

signal on_root_ready()

const STARTING_LIVES: int = 3

var player: PlayerCharacter2D
var player_spawn_point: Node2D
var lives_left: int

func accept_player_death() -> void:
	_handle_player_death()

func _ready() -> void:
	_init_game()
	on_root_ready.emit()

func _init_game() -> void:
	player = get_tree().get_first_node_in_group(Groups.player_character)
	player_spawn_point = get_tree().get_first_node_in_group(Groups.player_spawn)
	lives_left = STARTING_LIVES
	player.global_position = player_spawn_point.global_position

func _handle_player_death() -> void:
	lives_left -= 1
	if lives_left > 0:
		_respawn_player()
		SoundManager.play_player_hurt()
	else:
		_run_game_over()

func _respawn_player() -> void:
	player.on_spawn()
	player.global_position = player_spawn_point.global_position

func _run_game_over() -> void:
	get_tree().paused = true
	print("Game Over")
