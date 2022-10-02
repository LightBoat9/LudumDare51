extends KinematicBody2D


const MOVE_SPEED: int = 96


var direction: Vector2 = Vector2(1, 1)
var facing_prop: Node = null setget set_facing_prop
var holding_prop: Object = null setget set_holding_prop


onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var raycast: RayCast2D = $RayCast2D
onready var angle_cast: RayCast2D = $AngleCast
onready var holding_sprite: Sprite = $Holding

var press_input_vector = Vector2(1, 1)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_accept') and event.pressed:
		if facing_prop:
			facing_prop.interact()
			
	var horizontal_input = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	var vertical_input = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	
	var none_pressed = true
	for n in ['ui_right', 'ui_left', 'ui_up', 'ui_down']:
		if Input.is_action_pressed(n):
			none_pressed = false
			
	if Input.is_action_pressed('ui_right') or Input.is_action_pressed('ui_left'):
		press_input_vector.x = horizontal_input
	if Input.is_action_pressed('ui_down') or Input.is_action_pressed('ui_up'):
		press_input_vector.y = vertical_input


func _physics_process(delta: float) -> void:
	var horizontal_input = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	var vertical_input = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	
	var input_vector = Vector2(horizontal_input, vertical_input).normalized()
	var linear_velocity = input_vector * MOVE_SPEED
	
	if linear_velocity.x != 0:
		direction.x = -1 if linear_velocity.x < 0 else 1
		
	if linear_velocity.y != 0:
		direction.y = -1 if linear_velocity.y < 0 else 1
		
	sprite.flip_h = direction.x == -1
	holding_sprite.flip_h = direction.x == -1
	
	if linear_velocity.length() > 0:
		animation_player.play('walk_back' if direction.y == -1 else 'walk_front')
	else:
		animation_player.play('idle_back' if direction.y == -1 else 'idle_front')
	
	linear_velocity = move_and_slide(linear_velocity, Vector2())
	
	angle_cast.rotation = press_input_vector.angle()
	
	if input_vector.y < 0:
		raycast.rotation_degrees = 270
	elif input_vector.y > 0:
		raycast.rotation_degrees = 90
	elif input_vector.x > 0:
		raycast.rotation_degrees = 0
	elif input_vector.x < 0:
		raycast.rotation_degrees = 180
	
	if raycast.is_colliding() or angle_cast.is_colliding():
		var prop = angle_cast.get_collider()
		if raycast.is_colliding():
			prop = raycast.get_collider()
		self.facing_prop = prop
	else:
		self.facing_prop = null
	
	
func set_facing_prop(prop: Node) -> void:
	if facing_prop == prop:
		return
		
	if facing_prop:
		facing_prop.set_outline(false)
		
	facing_prop = prop
	
	if facing_prop:
		facing_prop.set_outline(true)
	
	
func set_holding_prop(prop: Object) -> void:
	if holding_prop:
		if holding_prop.is_tool:
			holding_prop.state = 1
		else:
			for p in get_tree().get_nodes_in_group('props'):
				if p.drop_name == holding_prop.prop_name:
					p.state = 0
				if p.prop_name == holding_prop.prop_name and prop:
					p.state = 1
		
	
	holding_prop = prop
	if holding_prop:
		holding_sprite.texture = PropManager.HoldingTextures[PropManager.HoldingNames[holding_prop.prop_name]]
	else:
		holding_sprite.texture = null
	
	if holding_prop and not holding_prop.is_tool:
		for p in get_tree().get_nodes_in_group('props'):
			if p.drop_name == holding_prop.prop_name and not p.is_tool:
				p.state = 1
