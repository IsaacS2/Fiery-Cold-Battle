extends RichTextLabel
class_name ScoreFieldUI

var displayed_score: int = 0

func _ready() -> void:
	bbcode_enabled = true
	displayed_score = AutoloadScoreTracker.current_score

func _process(delta: float) -> void:
	if displayed_score < AutoloadScoreTracker.current_score:
		displayed_score += 1
	var displayed_text: String = "[right]%s[/right]" % displayed_score
	text = displayed_text
