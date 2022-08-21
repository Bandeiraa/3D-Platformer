extends Spatial
class_name CrabMesh

onready var animation: AnimationPlayer = get_node("AnimationPlayer")

var on_action: bool = false

export(NodePath) onready var parent = get_node(parent) as KinematicBody

func move_behavior(velocity: Vector3) -> void:
	if on_action:
		return
		
	if velocity != Vector3.ZERO:
		animation.play("Walk")
		return
		
	animation.play("Idle")
	
	
func action_behavior(action: String) -> void:
	on_action = true
	animation.play(action)
	
	
func on_animation_finished(anim_name: String) -> void:
	var action_condition: bool = (
		anim_name == "HitRecieve"
	)
	
	if action_condition:
		on_action = false
		parent.set_physics_process(true)
