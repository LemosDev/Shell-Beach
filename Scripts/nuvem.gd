extends MeshInstance3D

var velocidade = -3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += velocidade * delta
	pass
