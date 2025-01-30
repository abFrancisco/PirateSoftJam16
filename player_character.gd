extends Node2D

var angle:float=0.0
var direction:Vector2=Vector2.ZERO



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle=%Knight.position.angle_to_point(get_global_mouse_position())
	direction=Vector2.RIGHT.rotated(angle)
	%SwordBody.apply_central_impulse(direction*10000*delta)
	queue_redraw()

func _draw():
	draw_line(%Knight.position, %Knight.position+direction*100,Color.RED, 5.0, true)
