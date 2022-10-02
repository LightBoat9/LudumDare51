tool
extends StateProp


func _update_state():
	._update_state()
	$CollisionShape2D.disabled = state == PropState.DEFAULT
