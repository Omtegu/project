extends Node2D

func _on_door_12_body_entered(body):
	queue_redraw()


func _on_door_23_area_entered(area):
	queue_free()
	pass # Replace with function body.
func on_door_34_area_entered(area):
	queue_free()
