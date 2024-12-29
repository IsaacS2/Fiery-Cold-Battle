extends Node

#region Test Tones

func play_test_loop():
	$test_tones/test_loop.play()

func play_test_sine():
	$test_tones/test_sine.play()

func play_test_saw():
	$test_tones/test_saw.play()

func play_test_square():
	$test_tones/test_square.play()
#endregion

func play_music():
	$music.play()

#region Projectiles

func play_projectile_bounce():
	$Projectiles/projectile_bounce.play()

func play_player_gun_fire():
	$Projectiles/player_gun_fire.play()

func play_enemy_gun_fire():
	$Projectiles/enemy_gun_fire.play()

func play_projectile_absorbed():
	$Projectiles/projectile_absorbed.play()
#endregion

#region elemental attacks

func play_fire_attack():
	$Attacks/fire_attack.play()

func play_ice_attack():
	$Attacks/ice_attack.play()
#endregion

func play_absorb_on():
	$Player/absorb_on.play
	
func _ready() -> void:
	play_music()
 
