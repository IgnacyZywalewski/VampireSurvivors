extends Node


const ICON_PATH = "res://assets/textures/icons/"
const UPGRADES = {
	"fireball_1": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Cos tu bedzie",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "weapon"
	},
	"fireball_2": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Cos tu bedzie 2",
		"level": "Level: 2",
		"prerequesits": ["fireball_1"],
		"type": "weapon"
	},
	"fireball_3": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Cos tu bedzie 3",
		"level": "Level: 3",
		"prerequesits": ["fireball_2"],
		"type": "weapon"
	},
	"fireball_4": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Cos tu bedzie 4",
		"level": "Level: 4",
		"prerequesits": ["fireball_3"],
		"type": "weapon"
	},
	"fireball_5": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Cos tu bedzie 5",
		"level": "Level: 5",
		"prerequesits": ["fireball_5"],
		"type": "weapon"
	},
	
	"black_hole_1": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Cos tu bedzie 1",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "weapon"
	},
	"black_hole_2": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Cos tu bedzie 2",
		"level": "Level: 2",
		"prerequesits": ["black_hole_1"],
		"type": "weapon"
	},
	"black_hole_3": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Cos tu bedzie 3",
		"level": "Level: 3",
		"prerequesits": ["black_hole_2"],
		"type": "weapon"
	},
	"black_hole_4": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Cos tu bedzie 4",
		"level": "Level: 4",
		"prerequesits": ["black_hole_3"],
		"type": "weapon"
	},
	"black_hole_5": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Cos tu bedzie 5",
		"level": "Level: 5",
		"prerequesits": ["black_hole_3"],
		"type": "weapon"
	},
	
	"shooting_star_1": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Cos tu bedzie 1",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "weapon"
	},
	"shooting_star_2": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Cos tu bedzie 2",
		"level": "Level: 2",
		"prerequesits": ["shooting_star_1"],
		"type": "weapon"
	},
	"shooting_star_3": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Cos tu bedzie 3",
		"level": "Level: 3",
		"prerequesits": ["shooting_star_2"],
		"type": "weapon"
	},
	"shooting_star_4": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Cos tu bedzie 4",
		"level": "Level: 4",
		"prerequesits": ["shooting_star_3"],
		"type": "weapon"
	},
	"shooting_star_5": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Cos tu bedzie 5",
		"level": "Level: 5",
		"prerequesits": ["shooting_star_4"],
		"type": "weapon"
	},
	
	"lightning_bolt_1": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Cos tu bedzie 1",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "weapon"
	},
	"lightning_bolt_2": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Cos tu bedzie 2",
		"level": "Level: 2",
		"prerequesits": ["lightning_bolt_1"],
		"type": "weapon"
	},
	"lightning_bolt_3": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Cos tu bedzie 3",
		"level": "Level: 3",
		"prerequesits": ["lightning_bolt_2"],
		"type": "weapon"
	},
	"lightning_bolt_4": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Cos tu bedzie 4",
		"level": "Level: 4",
		"prerequesits": ["lightning_bolt_3"],
		"type": "weapon"
	},
	"lightning_bolt_5": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Cos tu bedzie 5",
		"level": "Level: 5",
		"prerequesits": ["lightning_bolt_4"],
		"type": "weapon"
	},
	
	"food": {
		"icon": ICON_PATH + "food.png",
		"displayname": "Food",
		"details": "Heals you for 10 health",
		"level": "N/A",
		"prerequesits": [],
		"type": "passive"
	}
}
