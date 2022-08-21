extends Spatial
class_name BasicObject

onready var animation = get_node("Animation")

#Chamar uma animação (apenas para tornar o jogo mais dinâmico)
func interact() -> void:
	animation.play("squash_and_stretch")
