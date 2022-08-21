extends Area
class_name CollectableArea

onready var collision: CollisionShape = get_node("Collision")

export(int) var value_type
export(String) var collectable_type
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer

#Destruir o coletável ao interagir com o personagem
func on_collectable_body_entered(body) -> void:
	if body is Bunny:
		collectable_action(body)
		
		
#Executar uma determinada ação baseado no tipo de objeto que está sendo coletado
func collectable_action(body: Bunny) -> void:
	match collectable_type:
		"Fruit":
			body.update_health(value_type, "increase")
			
		"Star":
			GlobalData.update_stars()
			
		"Coin":
			GlobalData.update_coins()
			
		"BlueGem":
			GlobalData.update_gems("Blue")
			
		"PinkGem":
			GlobalData.update_gems("Pink")
			
		"GreenGem":
			GlobalData.update_gems("Green")
			
	collision.disabled = true
	animation.play("dissolve")
