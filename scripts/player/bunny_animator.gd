extends Spatial
class_name BunnyAnimator

onready var animation: AnimationPlayer = get_node("AnimationPlayer")

var suffix: String = ""

var on_action: bool = false
var on_roleplay_action: bool = false

export(NodePath) onready var bunny = get_node(bunny) as KinematicBody

func animate(velocity: Vector2) -> void:
	#Roleplay or Action Animations have priority
	if on_action or on_roleplay_action:
		return
		
	move_behavior(velocity)
	
	
func move_behavior(velocity: Vector2) -> void:
	suffix = get_weapon_state()
	if velocity != Vector2.ZERO:
		animation.play("Run" + suffix)
		return
		
	animation.play("Idle" + suffix)
	
	
#Logic to know which idle/run animation the player will trigger
func get_weapon_state() -> String:
	if bunny.is_weapon_triggered:
		return "_Gun"
		
	return ""
	
	
func action_behavior(action: String) -> void:
	on_action = true
	animation.play(action)
	
	
func roleplay_behavior(roleplay_action: String) -> void:
	if on_action:
		return
		
	on_roleplay_action = true
	animation.play(roleplay_action)
	
	
#What to do after an Animation
func on_animation_finished(anim_name: String) -> void:
	var roleplay_condition: bool = (
		anim_name == "Duck" or 
		anim_name == "Wave" or 
		anim_name == "Yes" or 
		anim_name == "No" or 
		anim_name == "Punch"
	)
	
	var action_condition: bool = (
		anim_name == "Jump_Land" or
		anim_name == "Idle_Shoot" or
		anim_name == "HitReact"
	)
	
	if roleplay_condition:
		on_roleplay_action = false
		bunny.set_physics_process(true)
		
	if anim_name == "Jump":
		animation.play("Jump_Idle")
		
	if action_condition:
		on_action = false
		bunny.set_physics_process(true)
