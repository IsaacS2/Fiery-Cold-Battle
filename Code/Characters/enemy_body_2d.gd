extends CharacterBody2D
class_name EnemyBody2D

@export var death_noise : String

var hit_points: int = 1
var element_vulnerable: Common.Elements

var patrol_path: Area2D
var path_col: CollisionShape2D
var extents = null
var has_path: bool = false

var fire_delay: float = 4
var fire_countdown: float = 0
var fire_point: FirePoint2D
var pool: ProjectilePool

var is_facing_right: bool = true

func _ready() -> void:
	fire_countdown = fire_delay
	var children: Array = get_children()
	for child in children:
		if child is FirePoint2D:
			fire_point = child
			break
	pool = get_tree().get_first_node_in_group(Groups.projectile_pool)
	fire_countdown = fire_delay
	_enemy_specific_ready_override()

func _enemy_specific_ready_override() -> void:
	pass

func accept_patrol_path(path_node: EnemyPatrolPath, col_node: CollisionShape2D) -> void:
	if has_path:
		return
	has_path = true
	patrol_path = path_node
	path_col = col_node
	extents = (path_col.shape as RectangleShape2D).extents

func _check_facing() -> void:
	var player_pos: Vector2 = AutoloadPlayerCharacterFinder.get_player_pos()
	var x_diff = global_position.x - player_pos.x
	if x_diff > 0 and is_facing_right:
		_swap_facing()
	elif x_diff < 0 and not is_facing_right:
		_swap_facing()

func _swap_facing() -> void:
	is_facing_right = not is_facing_right
	scale.x = -scale.x

func on_hit() -> void:
	hit_points -= 1
	if hit_points <= 0:
		_on_die()

func on_hit_elemental(element: Common.Elements) -> void:
	if element_vulnerable == element:
		on_hit()

func _on_die() -> void:
	AutoloadScoreTracker.accept_enemy_die(self)
	SoundManager.play_enemy_death(death_noise)
	queue_free()
