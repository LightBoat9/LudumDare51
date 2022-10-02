tool
class_name StateProp
extends Prop


enum PropState {
	DEFAULT, CHAOS1, CHAOS2, CHAOS3
}


export(PropState) var state: int = PropState.DEFAULT setget set_state
export var event_name: String = ''
export var chaos_level: int = 10
export var prop_name: String = ''
export var is_holding: bool = false
export var is_tool: bool = false
export var drop_name: String = ''


func _init() -> void:
	add_to_group('props')


func set_state(value: int) -> void:
	state = value
	call_deferred('_update_state')
	
	
func get_holding_index() -> int:
	if is_holding:
		return PropManager.HoldingNames[prop_name]
	else:
		return 0
		
		
func get_drop_index() -> int:
	return PropManager.HoldingNames[drop_name]
	
	
func _update_state() -> void:
	$Sprite.frame = min($Sprite.hframes, state)
	$Quote.visible = state != PropState.DEFAULT and not is_tool
	if state != PropState.DEFAULT and drop_name:
		for prop in get_tree().get_nodes_in_group('props'):
			if prop.prop_name == drop_name and prop.is_tool:
				prop.state = 1
	
	
func is_in_chaos() -> bool:
	return state != PropState.DEFAULT
	
	
func interact() -> void:
	var player = get_tree().get_nodes_in_group('player')[0]
	if drop_name and (not player.holding_prop or player.holding_prop.prop_name != drop_name):
		return
		
	if drop_name and player.holding_prop and not player.holding_prop.is_tool:
		if player.holding_prop.prop_name == drop_name:
			player.holding_prop = null
		else:
			return
	 
	if is_holding:
		player.holding_prop = self
		
	self.state = PropState.DEFAULT
	set_outline(false)
