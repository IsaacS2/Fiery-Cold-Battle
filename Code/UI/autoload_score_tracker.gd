extends Node

const PENGUIN_SCORE: int = 100
const JERBOA_SCORE: int = 100
const HELICOPTER_SCORE: int = 200

var current_score: int = 0

func accept_enemy_die(enemy: EnemyBody2D) -> void:
	var score: int = 0
	if enemy is PenguinBody2D:
		score = PENGUIN_SCORE
	elif enemy is JerboaBody2D:
		score = JERBOA_SCORE
	elif enemy is HelicopterBody2D:
		score = HELICOPTER_SCORE
	_add_score(score)

func _ready() -> void:
	_init_score()

func _init_score() -> void:
	_set_score(0)

func _set_score(new_score: int) -> void:
	current_score = new_score
	print("CURRENT SCORE: " + str(current_score))

func _add_score(add_value: int) -> void:
	print("_add_score() called")
	var score = current_score + add_value
	_set_score(score)
