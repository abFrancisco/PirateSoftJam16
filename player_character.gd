extends Node2D

var angle:float=0.0
var direction:Vector2=Vector2.ZERO
var swing_force:float=50000
var suction_force:float=50000



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var suction=Input.is_action_pressed("ui_accept")
	angle=%Knight.position.angle_to_point(get_global_mouse_position())
	direction=Vector2.RIGHT.rotated(angle)
	%Sword.apply_central_impulse(direction*swing_force*delta)
	if suction:
		#%Sword.apply_central_impulse((%Knight.position-%Sword.position).normalized()*suction_force*delta)
		%Knight.mass=10
	else:
		%Knight.mass=50
	queue_redraw()

func _draw():
	draw_line(%Knight.position, %Knight.position+direction*100,Color.RED, 5.0, true)
