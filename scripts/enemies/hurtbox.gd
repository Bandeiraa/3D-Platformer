extends Area
class_name Hurtbox

onready var collision: CollisionShape = get_node("Collision")
onready var attack_countdown: Timer = get_node("AttackCooldown")

export(int) var damage

func invulnerability_countdown(state: bool) -> void:
	change_collision_state(state)
	attack_countdown.start()
	
	
func on_attack_cooldown_timeout() -> void:
	change_collision_state(false)
	
	
func change_collision_state(state: bool) -> void:
	collision.disabled = state
