extends CanvasLayer
class_name DebuggerInfo

onready var fps_label: Label = get_node("Fps/FpsLabel")
onready var fps_background: ColorRect = get_node("Fps/FpsBackground")

func _process(_delta: float) -> void:
	fps_label.text = "Frames per Second: " + str(Engine.get_frames_per_second())
