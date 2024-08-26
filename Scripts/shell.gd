extends Area3D

const rotate_speed := 70.0
var start_pos := position.y
var end_pos := position.y + 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shell_tween := create_tween().set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	shell_tween.tween_property(self, "position:y", end_pos, 1.0).from(start_pos)
	shell_tween.tween_property(self, "position:y", start_pos, 1.0).from(end_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(rotate_speed * delta))


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		body.collect_shell()
		queue_free()
