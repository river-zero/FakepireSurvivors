extends CanvasLayer

@export var arena_time_manager: Node

@onready var lable = $%Label

func _process(delta):
	if arena_time_manager == null:
		return
	
	var time_elapsed = arena_time_manager.get_time_elapsed()
	lable.text = format_seconds_to_string(time_elapsed)

func format_seconds_to_string(seconds: float) -> String:
	var minutes = int(seconds) / 60
	var remaining_seconds = int(seconds) % 60
	return "%02d:%02d" % [minutes, remaining_seconds]
