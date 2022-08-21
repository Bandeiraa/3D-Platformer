extends Spatial
class_name Collectable

func on_animation_finished(_anim_name: String) -> void:
	queue_free()
