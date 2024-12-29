extends Node

func play_test_loop():
	$test_tones/test_loop.play()

func play_test_sine():
	$test_tones/test_sine.play()

func play_test_saw():
	$test_tones/test_saw.play()

func play_test_square():
	$test_tones/test_square.play()

func play_music():
	$music.play()



func _ready() -> void:
	play_music()
 
