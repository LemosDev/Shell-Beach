extends CharacterBody3D

enum {IDLE,RUN}
var curAnim = IDLE

const SPEED = 5.0
const JUMP_VELOCITY = 4.0
var smooth_animation := Vector2()


@onready var anim_tree: AnimationTree = $AnimationTree
@onready var shell_container: HBoxContainer = $HUD/shell_container
var shell := 0
@onready var mesh: Node3D = $mesh


func _physics_process(delta):
	handle_animations()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_rotate = $camera/horizontal.global_transform.basis.get_euler().y
	var input_dir := Input.get_vector("ui_esquerda", "ui_direita", "ui_cima", "ui_baixo")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3.UP, horizontal_rotate)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x, direction.z), delta * 5)
		curAnim = RUN
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		curAnim = IDLE
	
	smooth_animation = lerp(smooth_animation, input_dir, delta * 10)
	anim_tree.set("parameters/blend_position", smooth_animation.length())

	move_and_slide()

func handle_animations():
	match curAnim:
		IDLE:
			anim_tree.set("parameters/Movimento/transition_request", "idle")
		RUN:
			anim_tree.set("parameters/Movimento/transition_request", "run")

func jump():
	anim_tree.set("parameters/jump/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func collect_shell():
	shell += 1
	shell_container.update_shell(shell)
