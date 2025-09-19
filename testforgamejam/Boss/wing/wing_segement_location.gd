extends Node2D
var wing_segment_scene = preload("res://Boss/wing/wing_part.tscn")
var wing_end_scene = preload("res://Boss/wing/wing_end.tscn")
var chance_of_another_wing=0.5
var numb_of_segments=10 #this includes the end segment
var t=0

func _ready()-> void:
	
	#added as this add segments not including the end one
	for i in numb_of_segments-1:
		add_wing()
	pass
	
	var wings=len(get_children())
	#print(wings)
	for i in range(2,wings):
		move_to_end(i)
		pass
	
	#adding end wing
	var wingsceneend = wing_end_scene.instantiate()
	add_child(wingsceneend)
	#print(len(get_children()))
	move_to_end(numb_of_segments)
	
func _process(delta: float) -> void:
	var wings=len(get_children())

	for i in range(2,wings):
		get_child(i).rotation=(sin((i*0.2)+t)*0.8)
		#get_child(i).look_at(get_child(i-1).global_position)
		move_to_end(i)
		pass
	pass
	t+=delta
	if t>2*PI:
		t=0

	
func add_wing():
	#add a wing segment to the list
	var wingscene = wing_segment_scene.instantiate()
	$".".add_child(wingscene)
	
func move_to_end(i):
	var wing_now=get_child(i)
	var wing_last=get_child(i-1)
	wing_now.global_position=wing_last.get_child(0).global_position
	pass
