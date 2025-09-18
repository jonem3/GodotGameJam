extends Node2D

@export var maxPlanetSize = 100
@export var minPlanetSize = 50

@export var minPlanets = 10
@export var maxPlanets = 20

@export var minFreeSpace = 40

var planets: Array[Dictionary] = []
var spawn_area: Rect2

func _draw() -> void:
	for planet_data in planets:
		var pos = planet_data.position
		var rad = planet_data.radius
		
		draw_circle(pos, rad, Color(randf(), randf(), randf(), 1))

func _ready() -> void:
	randomize()
	
	spawn_area = get_viewport_rect()
	for i in range(randi_range(minPlanets, maxPlanets)):
		var overlaps = true
		var new_radius: int
		var new_pos: Vector2
		
		while overlaps:
			overlaps = false
			new_radius = randi_range(minPlanetSize, maxPlanetSize)
			
			new_pos = Vector2(
				randi_range(spawn_area.position.x, spawn_area.end.x ),
				randi_range(spawn_area.position.y, spawn_area.end.y)
			)
			
			for existing_planet in planets:
				var existing_pos = existing_planet.position
				var existing_radius = existing_planet.radius
				
				var min_distance = new_radius + existing_radius + minFreeSpace
		
				if new_pos.distance_squared_to(existing_pos) < min_distance * min_distance:
					overlaps = true
					break
					
		planets.append({"position": new_pos, "radius": new_radius})
		
	for planet_data in planets:
		var pos = planet_data.position
		var rad = planet_data.radius
		
		var physics_body = StaticBody2D.new()
		add_child(physics_body)
		physics_body.global_position = pos
		
		var collision_shape = CollisionShape2D.new()
		physics_body.add_child(collision_shape)
		
		var circle_shape = CircleShape2D.new()
		circle_shape.radius = rad
		collision_shape.shape = circle_shape
	
		
		
	queue_redraw()
		
		
