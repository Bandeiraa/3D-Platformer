extends CanvasLayer
class_name Interface

onready var container: VBoxContainer = get_node("Container")

onready var screen_shader: ColorRect = get_node("ScreenShader")
onready var cooldown_timer: Timer = get_node("ScreenShader/Cooldown")
onready var animation: AnimationPlayer = get_node("ScreenShader/Animation")

var can_change_camera_state: bool = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("camera") and can_change_camera_state:
		var _anim = animation.play("turn_shader_off") if screen_shader.is_visible() else animation.play("turn_shader_on")
		can_change_camera_state = false
		
		
func set_camera_state(new_state: bool) -> void:
	screen_shader.visible = new_state
	cooldown_timer.start()
	
	
func on_cooldown_timeout() -> void:
	can_change_camera_state = true
	
	
func update_collectable(type: String, amount: String) -> void:
	var target_label: Label = container.get_node(type)
	match type:
		"Stars":
			target_label.text = "Stars: " + amount
			
		"Gems":
			target_label.text = "Gems: " + amount
			
		"Coins":
			target_label.text = "Coins: " + amount
