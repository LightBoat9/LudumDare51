extends Control


var lose: bool = false setget set_lose


onready var win_container = $PanelContainer/VBoxContainer/Win
onready var lose_container = $PanelContainer/VBoxContainer/Lose


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('restart'):
		get_tree().reload_current_scene()
		get_tree().paused = false
	
	
func set_lose(value: bool) -> void:
	lose = value
	win_container.visible = not lose
	lose_container.visible = lose
