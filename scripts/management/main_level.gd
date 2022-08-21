extends Spatial
class_name Main

onready var bunny: KinematicBody = get_node("Bunny")

func _physics_process(_delta: float) -> void:
	send_player()
	
	
func send_player() -> void:
	get_tree().call_group("enemy", "get_player_ref", bunny)
