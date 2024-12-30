extends EnemyBody2D
class_name PenguinBody2D

const SPEED: float = 50.0


var direction_value: int = -1

func _physics_process(delta: float) -> void:
	_check_facing()
	
	fire_countdown -= delta
	if fire_countdown < 0:
		fire_countdown = fire_delay
		_fire_projectile()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = SPEED * direction_value
	
	if patrol_path and path_col and extents:
		#if position.x < patrol_path.global_position.x - extents.x or position.x > patrol_path.global_position.x + extents.x:
		if position.x < patrol_path.global_position.x - (extents.x):
			direction_value = 1
		elif position.x > patrol_path.global_position.x + extents.x:
			direction_value = -1
	
	move_and_slide()

func _fire_projectile() -> void:
	var projectile: Projectile2D = pool.get_projectile()
	if projectile:
		projectile.global_position = fire_point.global_position
		SoundManager.play_enemy_gun_fire()
		projectile.activate()
		projectile.set_path()

func _on_collision(collision: KinematicCollision2D) -> void:
	print(collision)
