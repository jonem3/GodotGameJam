extends CharacterBody2D
@export var speed = 400
@export var dash_speed = 1000
	
var gravity_source = null
@export var gravity_strength = 0.0

var can_dash=0
var dash_dir
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var gravity_vector = apply_gravity(_delta)
	#apply_movement(gravity_vector)
	#player_dash()
	move_and_slide()
	


func apply_gravity(delta: float) -> Vector2:
	var gravity_dir = Vector2.ZERO
	if is_instance_valid(gravity_source):
		gravity_dir = global_position.direction_to(gravity_source.global_position)
		velocity += gravity_dir * gravity_strength * delta
	return gravity_dir

func apply_movement(gravity_vector: Vector2) -> void:
	# Don't allow regular movement while dashing
	if not $Timer_dash_effect.is_stopped():
		return

	# Get left/right input
	var input_axis = Input.get_axis("Move_left", "Move_right")
	
	# If gravity exists, move perpendicular to it. Otherwise, move horizontally.
	var move_direction: Vector2
	if gravity_vector != Vector2.ZERO:
		move_direction = gravity_vector.orthogonal() # Get the perpendicular vector for "sideways"
	else:
		move_direction = Vector2.RIGHT # Default to horizontal movement if no gravity

	velocity = move_direction * input_axis * speed

func player_dash() -> void:
	
	if Input.is_action_just_pressed("Secondary_action_Dash") and can_dash:
		#print("dash")
		dash_dir=global_position.direction_to(get_global_mouse_position())
		$Timer_dash.start()
		$Timer_dash_effect.start()
	else:
		pass
	if not ($Timer_dash_effect.is_stopped()):
		velocity=dash_dir*dash_speed
	else:
		can_dash=false
	if $Timer_dash.is_stopped():
		can_dash=true
	pass


func _on_gravity_detector_area_entered(area):
	# When we enter a gravity field, store its information
	gravity_source = area
	gravity_strength = area.gravity

func _on_gravity_detector_area_exited(area):
	# When we leave, clear the information
	if area == gravity_source:
		gravity_source = null
		gravity_strength = 0.0
