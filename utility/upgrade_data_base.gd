extends Node2D


const ICON_PATH = "res://assets/textures/icons/"
const UPGRADES = {
	"fireball1": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Cos tu bedzie",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "weapon"
	},
	"fireball2": {
		"icon": ICON_PATH + "fireballl_icon.png",
		"displayname": "Fireball",
		"details": "Cos tu bedzie 2",
		"level": "Level: 2",
		"prerequesits": ["fireball1"],
		"type": "weapon"
	},
	"fireball3": {
		"icon": ICON_PATH + "fireballl_icon.png",
		"displayname": "Fireball",
		"details": "Cos tu bedzie 3",
		"level": "Level: 3",
		"prerequesits": ["fireball2"],
		"type": "weapon"
	}
}
