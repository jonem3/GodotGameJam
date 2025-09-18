extends CharacterBody2D
@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_input(delta)
	move_and_slide()

func get_input(delta: float) -> void:
	var input_direction = Input.get_vector("Move_left","Move_right","temp","temp")
	#print(input_direction)
	velocity=input_direction*speed
