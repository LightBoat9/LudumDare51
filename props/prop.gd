class_name Prop
extends Node2D


const PropMaterial: ShaderMaterial = preload('res://props/prop_material.tres')


func _ready() -> void:
	get_sprite_base().material = PropMaterial.duplicate(true)
	
	
func get_sprite_base() -> Node:
	return $Sprite
	
	
func set_outline(value: bool) -> void:
	get_sprite_base().material.set_shader_param('outline', value and is_in_chaos())
	
	
func is_in_chaos() -> bool:
	return false
	
	
func interact() -> void:
	pass
