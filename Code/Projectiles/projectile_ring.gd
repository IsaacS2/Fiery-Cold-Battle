extends Node2D
class_name ProjectileRing

const MAX_PROJECTILES: int = 8

var pool: ProjectilePool
var ring_points: Array
var captured_projectiles: Array

func _ready() -> void:
	captured_projectiles.clear()
	var children: Array = get_children()
	for child in children:
		if child is ProjectileRingPoint:
			ring_points.append(child)
	pool = get_tree().get_first_node_in_group(Groups.projectile_pool)

func attempt_capture_projectile(projectile: Projectile2D) -> void:
	if captured_projectiles.size() < MAX_PROJECTILES:
		_capture_projectile(projectile)

func _capture_projectile(projectile: Projectile2D) -> void:
	var index: int = captured_projectiles.size()
	projectile.capture()
	SoundManager.play_projectile_absorbed()
	captured_projectiles.append(projectile)
	if projectile.get_parent():
		projectile.get_parent().remove_child(projectile)
	add_child(projectile)
	projectile.global_position = ring_points[index].global_position

func fire_projectiles() -> void:
	if captured_projectiles == null or captured_projectiles.size() < 1:
		return
	for projectile in captured_projectiles:
		_fire_projectile(projectile)
	captured_projectiles.clear()

func _fire_projectile(projectile: Projectile2D) -> void:
	var pos: Vector2 = projectile.global_position
	remove_child(projectile)
	pool.add_child(projectile)
	projectile.global_position = pos
	SoundManager.play_player_gun_fire()
	projectile.fire_from_player(global_position)
