extends CharacterBody2D
class_name EnemyBody2D

var hit_points: int = 1

var patrol_path: Area2D
var path_col: CollisionShape2D
var extents = null
var has_path: bool = false

var fire_delay: float = 4
var fire_countdown: float = 0
var fire_point: FirePoint2D
var pool: ProjectilePool

func _ready() -> void:
	fire_countdown = fire_delay
	var children: Array = get_children()
	for child in children:
		if child is FirePoint2D:
			fire_point = child
			break
	pool = get_tree().get_first_node_in_group(Groups.projectile_pool)
	fire_countdown = fire_delay

func accept_patrol_path(path_node: EnemyPatrolPath, col_node: CollisionShape2D) -> void:
	if has_path:
		return
	has_path = true
	patrol_path = path_node
	path_col = col_node
	extents = (path_col.shape as RectangleShape2D).extents

func on_hit() -> void:
	hit_points -= 1
	if hit_points <= 0:
		_on_die()

func _on_die() -> void:
	queue_free()
