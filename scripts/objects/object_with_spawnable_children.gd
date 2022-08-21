extends BasicObject
class_name ObjectWithSpawnableChildren

var spawn_list: Array = [
	Vector2(-1, -0.5),
	Vector2(0.5, 1)
]

export(int) var spawn_gap
export(int) var spawn_height
export(int) var spawn_amount

export(PackedScene) var spawnable

func _ready() -> void:
	randomize()
	
	
func interact() -> void:
	animation.play("squash_and_stretch")
	
	#Gerar um número aleatório e spawnar o objeto, caso o número seja menor que
	#a probabilidade de spawn e ainda existam objetos a serem spawnados
	var random_number: int = randi() % 100 + 1
	if random_number <= spawn_gap and spawn_amount > 0:
		spawn_object()
		
		
func spawn_object() -> void:
	#Subtraindo da quantidade máxima, para não spawnar objetos de forma infinita
	spawn_amount -= 1
	
	#Gerar as posições de spawn do objeto
	var random_x_index: int = randi() % spawn_list.size()
	var random_x_position: Vector2 = spawn_list[random_x_index]
	
	var random_z_index: int = randi() % spawn_list.size()
	var random_z_position: Vector2 = spawn_list[random_z_index]
	
	#Spawnar o objeto
	var object_to_spawn = spawnable.instance()
	get_tree().root.call_deferred("add_child", object_to_spawn)
	object_to_spawn.translation = Vector3(
		translation.x + rand_range(random_x_position.x, random_x_position.y),
		translation.y + spawn_height,
		translation.z + rand_range(random_z_position.x, random_z_position.y)
	)
