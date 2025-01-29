extends Node2D

var wall_draw : Array[PackedVector2Array]
var tessellate_degrees : float = 1.0
var max_stages : int = 5
var ray_point : Vector2 = Vector2.ZERO
@export var player : CharacterBody2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_graph_duplicate"):
		get_tree().reload_current_scene()

func _ready():
	print_exec_time(process_terrain)

func _process(delta: float) -> void:
	var hInput=Input.get_axis("ui_left", "ui_right")
	var vInput=Input.get_axis("ui_up", "ui_down")
	
	%Camera2D.position+=Vector2(hInput*500*delta, vInput*500*delta)
	%fps.text=str(Engine.get_frames_per_second())

func print_exec_time(function:Callable) -> void:
	var start_time=Time.get_ticks_usec()
	function.call()
	print(str(function.get_method())+" took "+str(Time.get_ticks_usec()-start_time)+"μs to run")

func process_terrain() -> void:
	for child in %Terrain.get_children():
		var baked_points:PackedVector2Array=child.curve.get_baked_points()
		var offset_points:PackedVector2Array=PackedVector2Array()
		var offset_position:Vector2=child.position
		var offset_scale:Vector2=child.scale
		var offset_rotation:float=child.rotation
		for point in baked_points:
			offset_points.append(((point*offset_scale).rotated(offset_rotation))+offset_position)
		wall_draw.append(offset_points)
	queue_redraw()

func _draw():
	var i = 0
	for group_points in wall_draw:
		i += 1
		draw_colored_polygon(group_points, Color("0f0f19"))
		draw_polyline(group_points, Color(1, 1, 1, 1), 0.8, true)
		var wall_body = StaticBody2D.new()
		var collision_shape = CollisionPolygon2D.new()
		collision_shape.build_mode = CollisionPolygon2D.BUILD_SEGMENTS
		collision_shape.set_polygon(group_points)
		wall_body.add_child(collision_shape)
		add_child(wall_body)
