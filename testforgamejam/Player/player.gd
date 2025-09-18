extends CharacterBody2D
@export var speed = 400
@export var dash_speed = 1000
var can_dash=0
var dash_dir
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	get_input()
	#print("moving")

	player_dash()
	move_and_slide()
	#print(global_position.direction_to(get_global_mouse_position()))
	#print(dash_dir)


func get_input() -> void:
	var input_direction = Input.get_axis("Move_left","Move_right")
	#print(input_direction)
	velocity.x=input_direction*speed
	velocity.y=0

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
