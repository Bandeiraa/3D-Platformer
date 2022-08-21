extends MeshInstance
class_name BunnyProjectile

var bunny: KinematicBody = null

export(int) var speed = 30
export(int) var damage = 3

#Mover o projétil
func _physics_process(delta: float) -> void:
	var forward_direction: Vector3 = global_transform.basis.z.normalized()
	global_translate(forward_direction * speed * delta)
	
	
#Executar uma lógica baseado no corpo que está entrando em contato com o projétil
#Se for um corpo com física (Árvore, Mato, Pedra), chamar o método de interagir
#Se for um inimigo, atualizar a vida dele com o dano do projétil
func on_body_entered(body) -> void:
	if body is StaticBody:
		body.owner.interact()
		queue_free()
		
	if body is Enemy:
		body.update_health(damage)
		queue_free()
		
		
#O projétil tem um tempo de vida útil, depois de x segundos após o spawn
#O projétil será destruido (Melhorar o desempenho do jogo)
func on_projectile_lifetime_timeout():
	queue_free()
