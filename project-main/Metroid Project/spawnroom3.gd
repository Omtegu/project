extends Node2D

func _on_door_12_body_entered(body):
	queue_free()



func _on_door_34_area_entered(area):
	queue_redraw()
	pass # Replace with function body.


func _on_door_23_area_entered(area):
	queue_redraw()
	pass # Replace with function body.
