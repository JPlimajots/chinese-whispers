extends CanvasModulate

@export var day_cycle_gradient: Gradient

var total_calls_in_shift: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_calls_in_shift = NarrativeManager.available_calls.size()
	color = day_cycle_gradient.sample(0.0)
	ConnectionManager.clear_ui_text.connect(_advance_time)


func _advance_time():
	if total_calls_in_shift == 0:
		return
	
	var calls_remaining = NarrativeManager.available_calls.size()
	var calls_completed = total_calls_in_shift - calls_remaining
	var time_progress = float(calls_completed) / float(total_calls_in_shift)
	var target_color = day_cycle_gradient.sample(time_progress)
	var tween = create_tween()
	
	tween.tween_property(self, "color", target_color, 4.0).set_trans(Tween.TRANS_SINE)
