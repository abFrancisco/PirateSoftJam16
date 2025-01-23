extends Node3D

var boxes:Array[CSGBox3D]=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var hinput=Input.get_axis("ui_left", "ui_right")
	var vinput=Input.get_axis("ui_up", "ui_down")
	var move_vector=Vector3(hinput*delta, 0, vinput*delta)*5
	for box in boxes:
		box.transform.origin+=move_vector
	
	%Fps.text="fps  ="+str(Engine.get_frames_per_second())
	%count.text="count="+str(boxes.size())

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var box=CSGBox3D.new()
		box.size.y=2
		box.operation = CSGShape3D.OPERATION_SUBTRACTION
		box.transform.origin = Vector3(randf_range(-10,10),0,randf_range(-10,10))
		boxes.append(box)
		$CSGCombiner3D.add_child(box)
	if event.is_action_pressed("ui_text_delete"):
		boxes.pop_front().queue_free()
