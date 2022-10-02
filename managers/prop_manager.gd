extends Node


enum HoldingProps {
	NONE, TRASH, SCISSORS, WRENCH, HAMMER
}

const HoldingTextures = {
	HoldingProps.NONE: null,
	HoldingProps.TRASH: preload('res://player/holding_trash.png'),
	HoldingProps.SCISSORS: preload('res://player/holding_scissors.png'),
	HoldingProps.WRENCH: preload('res://player/holding_wrench.png'),
	HoldingProps.HAMMER: preload('res://player/holding_hammer.png')
}
	
const HoldingNames = {
	'': HoldingProps.NONE,
	'trash': HoldingProps.TRASH,
	'scissors': HoldingProps.SCISSORS,
	'wrench': HoldingProps.WRENCH,
	'hammer': HoldingProps.HAMMER
}
