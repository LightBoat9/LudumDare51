extends VBoxContainer


var events: Array = []


onready var timer = $Timer
onready var clock_label = $HBoxContainer/Label
onready var clock_hand = $HBoxContainer/TimerLabel/Hand


var max_countdown: int = 30
var countdown: int = max_countdown


func _process(delta: float) -> void:
	clock_hand.rect_rotation = -360 * (timer.time_left / timer.wait_time) - 90
	clock_label.text = '%2.f' % timer.time_left
	update_gui()
	var chaos_level = EventManager.get_chaos_level()
	var end_screen = get_tree().get_nodes_in_group('end_screen')[0]
	if chaos_level >= 100:
		end_screen.visible = true
		end_screen.lose = true
		get_tree().paused = true
	if countdown < 0:
		end_screen.visible = true
		end_screen.lose = false
		get_tree().paused = true


func update_gui() -> void:
	var new_events = EventManager.get_event_list()
	if events != new_events:
		events = new_events
		
		var labels = get_tree().get_nodes_in_group('event_labels')
		
		for label in labels:
			label.visible = false
		
		for i in range(min(len(labels), len(events))):
			labels[i].get_child(0).parse_bbcode('[color=#f7cf91][right]([color=#f09f71]+%s%%[/color]) %s[/right][/color]' % [events[i].chaos_level,events[i].event_name])
			labels[i].visible = true


func _on_Timer_timeout() -> void:
	countdown -= 1
	
	var events_count = get_curse_count()
	
	$AudioCurse.play()
		
	for i in range(events_count):
		EventManager.add_random_event()
	
	
func get_curse_count() -> int:
	var events_count = 0
	var remaining = max_countdown - countdown
	if countdown >= 0:
		if remaining < 5:
			events_count = 1
		elif remaining < 15:
			events_count = 2
		else:
			events_count = 3
	return events_count
