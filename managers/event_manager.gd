extends Node


func get_chaos_level() -> int:
	var walls = get_tree().get_nodes_in_group('wall_tilemap')[0]
	var level = 0
	for child in walls.get_children():
		if child is StateProp:
			if child.state != 0 and child.event_name:
				level += child.chaos_level
	return level
	
	
func get_event_list() -> Array:
	var walls = get_tree().get_nodes_in_group('wall_tilemap')[0]
	var list = []
	for child in walls.get_children():
		if child is StateProp:
			if child.state != 0 and child.event_name:
				list.append(child)
	return list
	
	
func add_random_event() -> void:
	var walls = get_tree().get_nodes_in_group('wall_tilemap')[0]
	var list = []
	for child in walls.get_children():
		if child is StateProp:
			if child.state == 0 and child.event_name:
				list.append(child)
	randomize()
	if list:
		list[int(rand_range(0, len(list)))].state = 1
		return
