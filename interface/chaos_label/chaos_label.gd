extends HBoxContainer


onready var label: RichTextLabel = $VBoxContainer/PanelContainer/RichTextLabel
onready var spells_left: RichTextLabel = $VBoxContainer/SpellsLeft/RichTextLabel
onready var curse_count: RichTextLabel = $VBoxContainer/CurseCount/RichTextLabel


func _process(delta: float) -> void:
	update_gui()


func update_gui() -> void:
	var chaos_level = EventManager.get_chaos_level()
	if chaos_level < 40:
		label.parse_bbcode('[center][color=#%s]%s%% Chaos[/color][/center]' % ['64b082', chaos_level])
	elif chaos_level < 60:
		label.parse_bbcode('[center][color=#%s]%s%% Chaos[/color][/center]' % ['f09f71', chaos_level])
	else:
		label.parse_bbcode('[center][color=#%s]%s%% Chaos[/color][/center]' % ['d8725e', chaos_level])
	
	var remaining = max(0, get_tree().get_nodes_in_group('events')[0].countdown)
	var count = get_tree().get_nodes_in_group('events')[0].get_curse_count()
	var count_color = ['64b082', 'f09f71', 'd8725e'][count-1]
	
	spells_left.parse_bbcode('[center]Spells Remaining: [color=#%s]%s[/color][/center]' % [count_color, remaining])
	curse_count.parse_bbcode('[center][color=#%s]%s Curse(s) Per Spell[/color][/center]' % [count_color, count])
