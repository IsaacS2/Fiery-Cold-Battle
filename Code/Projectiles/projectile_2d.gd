extends CharacterBody2D
class_name Projectile2D

const SPEED: float = 100.0
const FIRE_FACTOR: float = 3.0
const MAX_COLLISIONS: int = 1

var path_vector: Vector2
var collisions_left: int = 1

var is_captured: bool = false

func set_path() -> void:
	var player: PlayerCharacter2D = get_tree().get_first_node_in_group(Groups.player_character)
	if player:
		path_vector = (player.global_position - global_position).normalized()
	else:
		path_vector = Vector2.ZERO
	velocity = path_vector * SPEED

func fire_from_player(start_pos: Vector2) -> void:
	path_vector = (global_position - start_pos).normalized()
	_rearm()
	velocity = path_vector * SPEED * FIRE_FACTOR

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		_on_collision(collision)
		
func _on_collision(collision: KinematicCollision2D) -> void:
	#print(collision)
	var collider = collision.get_collider()
	var player = collider as PlayerCharacter2D
	if player:
		player.on_hit()
		deactivate()
	elif collider is EnemyBody2D:
		print("Enemy hit")
		var enemy = collider as EnemyBody2D
		enemy.on_hit()
		deactivate()
	elif collisions_left > 0:
		velocity = velocity.bounce(collision.get_normal())
		#bounce Sound
		SoundManager.play_projectile_bounce()
		collisions_left -= 1
	else:
		deactivate()

func activate() -> void:
	visible = true
	collision_layer = 1
	collision_mask = 1
	velocity = Vector2.ZERO
	collisions_left = MAX_COLLISIONS
	is_captured = false

func deactivate() -> void:
	visible = false
	collision_layer = 0
	collision_mask = 0
	velocity = Vector2.ZERO
	global_position = Vector2(-1000, -1000)
	is_captured = false

func capture() -> void:
	collision_layer = 0
	collision_mask = 0
	velocity = Vector2.ZERO
	is_captured = true

func _rearm() -> void:
	collision_layer = 2
	collision_mask = 2
	collisions_left = 0
