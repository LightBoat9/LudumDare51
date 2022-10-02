tool
extends Node2D


enum QuoteType {
	ALERT, DROP, PICKUP, SCISSORS, WRENCH, HAMMER
}

export(QuoteType) var quote_type: int = QuoteType.ALERT setget set_quote_type


func set_quote_type(type: int) -> void:
	quote_type = type
	call_deferred('_update_type')
	
	
func _update_type() -> void:
	$Sprite.frame = quote_type
