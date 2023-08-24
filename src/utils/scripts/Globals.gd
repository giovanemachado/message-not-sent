extends Node

const SCENES = {
	CREDITS = 'credits_scene',
	EMERGE = 'emerge_scene',
	SUBMERGE = 'submerge_scene',
	DEATH = 'death_scene',
	GAME_OVER = 'game_over_scene',
	MAIN_MENU = 'menu_scene',
}

const CHARACTERS = {
	MAN = 'man',
	DAUGHTER = 'daughter',
	BOSS = 'boss',
}

const GROUPS = {
	OBSTACLES = 'obstacle'
}

# first 1
# last 5
var current_level: int = 1

#enum ExampleEnum {A, B}
#
#const EXAMPLE_CONST = 'const value'
#
#const EXAMPLE_CONST_OBJECT = { 
#		PROPERTY1 = 'preperty 1', 
#		PROPERTY2 = 'property 2',
#}

# To use:
# Globals.EXAMPLE_CONST
