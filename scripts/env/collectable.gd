extends Area
class_name CollectableA

onready var mesh: MeshInstance = get_node("Mesh")
onready var collision: CollisionShape = get_node("Collision")
onready var animation: AnimationPlayer = get_node("Animation")

export(int) var rotation_speed = 60
export(String) var collectable_type

func on_body_entered(_body) -> void:
	match collectable_type:
		"Coin":
			GlobalData.update_coins()
			
		"Star":
			GlobalData.update_stars()
			
		"BlueGem":
			GlobalData.update_gems("Blue")
			
	collision.disabled = true
	animation.play("dissolve")
	
	
func on_animation_finished(_anim_name: String) -> void:
	queue_free()
	
	
func _physics_process(delta: float) -> void:
	mesh.rotation_degrees.y += delta * rotation_speed
