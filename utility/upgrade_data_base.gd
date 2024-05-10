extends Node

const ICON_PATH = "res://assets/textures/icons/"
const UPGRADES = {
	"fireball_1": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Fires at the nearest enemy",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "weapon"
	},
	"fireball_2": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Fires 1 more projectile",
		"level": "Level: 2",
		"prerequesits": ["fireball_1"],
		"type": "weapon"
	},
	"fireball_3": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Passes through 1 more enemy",
		"level": "Level: 3",
		"prerequesits": ["fireball_2"],
		"type": "weapon"
	},
	"fireball_4": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Fires 1 more projectile",
		"level": "Level: 4",
		"prerequesits": ["fireball_3"],
		"type": "weapon"
	},
	"fireball_5": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Damage increased by 1",
		"level": "Level: 5",
		"prerequesits": ["fireball_4"],
		"type": "weapon"
	},
	"fireball_6": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Fires 1 more projectile",
		"level": "Level: 6",
		"prerequesits": ["fireball_5"],
		"type": "weapon"
	},
	"fireball_7": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Passes through 1 more enemy",
		"level": "Level: 7",
		"prerequesits": ["fireball_6"],
		"type": "weapon"
	},
	"fireball_8": {
		"icon": ICON_PATH + "fireball_icon.png",
		"displayname": "Fireball",
		"details": "Damage increased by 3",
		"level": "Level: 8",
		"prerequesits": ["fireball_7"],
		"type": "weapon"
	},
	
	"black_hole_1": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Damages nearby enemies",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "weapon"
	},
	"black_hole_2": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Base Area up by 40%\nBase Damage up by 0.3",
		"level": "Level: 2",
		"prerequesits": ["black_hole_1"],
		"type": "weapon"
	},
	"black_hole_3": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Cooldown reduced by 0.2 seconds\nKnockback increased by 50%",
		"level": "Level: 3",
		"prerequesits": ["black_hole_2"],
		"type": "weapon"
	},
	"black_hole_4": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Base Area up by 20%\nBase Damage up by 0.3",
		"level": "Level: 4",
		"prerequesits": ["black_hole_3"],
		"type": "weapon"
	},
	"black_hole_5": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Cooldown reduced by 0.3 seconds\nKnockback increased by 50%",
		"level": "Level: 5",
		"prerequesits": ["black_hole_4"],
		"type": "weapon"
	},
	"black_hole_6": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Base Area up by 20%\nBase Damage up by 0.2",
		"level": "Level: 6",
		"prerequesits": ["black_hole_5"],
		"type": "weapon"
	},
	"black_hole_7": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Cooldown reduced by 0.2 seconds",
		"level": "Level: 7",
		"prerequesits": ["black_hole_6"],
		"type": "weapon"
	},
	"black_hole_8": {
		"icon": ICON_PATH + "black_hole_icon.png",
		"displayname": "Black Hole",
		"details": "Base Area up by 20%\nBase Damage up by 1",
		"level": "Level: 8",
		"prerequesits": ["black_hole_7"],
		"type": "weapon"
	},
	
	"shooting_star_1": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Passes through enemies,\nbounces off the walls",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "weapon"
	},
	"shooting_star_2": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Base Damage up by 0.6\nBase Speed up by 50%",
		"level": "Level: 2",
		"prerequesits": ["shooting_star_1"],
		"type": "weapon"
	},
	"shooting_star_3": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Base Damage up by 0.5\nNumber of bounces up by 2",
		"level": "Level: 3",
		"prerequesits": ["shooting_star_2"],
		"type": "weapon"
	},
	"shooting_star_4": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Fires 1 more projectile",
		"level": "Level: 4",
		"prerequesits": ["shooting_star_3"],
		"type": "weapon"
	},
	"shooting_star_5": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Base Damage up by 0.5\nBase Speed up by 25%",
		"level": "Level: 5",
		"prerequesits": ["shooting_star_4"],
		"type": "weapon"
	},
	"shooting_star_6": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Base Damage up by 0.5\nNumber of bounces up by 2",
		"level": "Level: 6",
		"prerequesits": ["shooting_star_5"],
		"type": "weapon"
	},
	"shooting_star_7": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Fires 1 more projectile",
		"level": "Level: 7",
		"prerequesits": ["shooting_star_6"],
		"type": "weapon"
	},
	"shooting_star_8": {
		"icon": ICON_PATH + "shooting_star_icon.png",
		"displayname": "Shooting Star",
		"details": "Base Damage up by 0.5\nNumber of bounces up by 2",
		"level": "Level: 8",
		"prerequesits": ["shooting_star_7"],
		"type": "weapon"
	},
	
	"lightning_bolt_1": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Strikes at random enemies",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "weapon"
	},
	"lightning_bolt_2": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Fires 1 more projectile",
		"level": "Level: 2",
		"prerequesits": ["lightning_bolt_1"],
		"type": "weapon"
	},
	"lightning_bolt_3": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Base Area up by 20%. Base Damage up by 1",
		"level": "Level: 3",
		"prerequesits": ["lightning_bolt_2"],
		"type": "weapon"
	},
	"lightning_bolt_4": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Fires 1 more projectile",
		"level": "Level: 4",
		"prerequesits": ["lightning_bolt_3"],
		"type": "weapon"
	},
	"lightning_bolt_5": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Base Area up by 40%. Base Damage up by 0.5",
		"level": "Level: 5",
		"prerequesits": ["lightning_bolt_4"],
		"type": "weapon"
	},
	"lightning_bolt_6": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Fires 1 more projectile",
		"level": "Level: 6",
		"prerequesits": ["lightning_bolt_5"],
		"type": "weapon"
	},
	"lightning_bolt_7": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Base Area up by 20%. Base Damage up by 0.5",
		"level": "Level: 7",
		"prerequesits": ["lightning_bolt_6"],
		"type": "weapon"
	},
	"lightning_bolt_8": {
		"icon": ICON_PATH + "lightning_bolt_icon.png",
		"displayname": "Lightning Bolt",
		"details": "Fires 1 more projectile",
		"level": "Level: 8",
		"prerequesits": ["lightning_bolt_7"],
		"type": "weapon"
	},
	
	"ring_1": {
		"icon": ICON_PATH + "ring_icon.png",
		"displayname": "Ring",
		"details": "ALL Weapons fire 1 more projectiles",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "passive"
	},
	"ring_2": {
		"icon": ICON_PATH + "ring_icon.png",
		"displayname": "Ring",
		"details": "ALL Weapons fire 1 more projectiles",
		"level": "Level: 2",
		"prerequesits": ["ring_1"],
		"type": "passive"
	},
	
	"wings_1": {
		"icon": ICON_PATH + "wings_icon.png",
		"displayname": "Wings",
		"details": "Character moves 10% faster",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "passive"
	},
	"wings_2": {
		"icon": ICON_PATH + "wings_icon.png",
		"displayname": "Wings",
		"details": "Movement speed increases by 10%",
		"level": "Level: 2",
		"prerequesits": ["wings_1"],
		"type": "passive"
	},
	"wings_3": {
		"icon": ICON_PATH + "wings_icon.png",
		"displayname": "Wings",
		"details": "Movement speed increases by 10%",
		"level": "Level: 2",
		"prerequesits": ["wings_2"],
		"type": "passive"
	},
	"wings_4": {
		"icon": ICON_PATH + "wings_icon.png",
		"displayname": "Wings",
		"details": "Movement speed increases by 10%",
		"level": "Level: 4",
		"prerequesits": ["wings_3"],
		"type": "passive"
	},
	"wings_5": {
		"icon": ICON_PATH + "wings_icon.png",
		"displayname": "Wings",
		"details": "Movement speed increases by 10%",
		"level": "Level: 5",
		"prerequesits": ["wings_4"],
		"type": "passive"
	},
	
	"regeneration_1": {
		"icon": ICON_PATH + "regeneration_icon.png",
		"displayname": "Regeneration",
		"details": "Character recovers 0.2 HP per second",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "passive"
	},
	"regeneration_2": {
		"icon": ICON_PATH + "regeneration_icon.png",
		"displayname": "Regeneration",
		"details": "Health recovery increases by 0.2 HP per second",
		"level": "Level: 2",
		"prerequesits": ["regeneration_1"],
		"type": "passive"
	},
	"regeneration_3": {
		"icon": ICON_PATH + "regeneration_icon.png",
		"displayname": "Regeneration",
		"details": "Health recovery increases by 0.2 HP per second",
		"level": "Level: 3",
		"prerequesits": ["regeneration_2"],
		"type": "passive"
	},
	"regeneration_4": {
		"icon": ICON_PATH + "regeneration_icon.png",
		"displayname": "Regeneration",
		"details": "Health recovery increases by 0.2 HP per second",
		"level": "Level: 4",
		"prerequesits": ["regeneration_3"],
		"type": "passive"
	},
	"regeneration_5": {
		"icon": ICON_PATH + "regeneration_icon.png",
		"displayname": "Regeneration",
		"details": "Health recovery increases by 0.2 HP per second",
		"level": "Level: 5",
		"prerequesits": ["regeneration_4"],
		"type": "passive"
	},
	
	"shield_1": {
		"icon": ICON_PATH + "shield_icon.png",
		"displayname": "Shield",
		"details": "Reduces incoming damage by 1",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "passive"
	},
	"shield_2": {
		"icon": ICON_PATH + "shield_icon.png",
		"displayname": "Shield",
		"details": "Damage reduced increases by 1",
		"level": "Level: 2",
		"prerequesits": ["shield_1"],
		"type": "passive"
	},
	"shield_3": {
		"icon": ICON_PATH + "shield_icon.png",
		"displayname": "Shield",
		"details": "Damage reduced increases by 1",
		"level": "Level: 3",
		"prerequesits": ["shield_2"],
		"type": "passive"
	},
	"shield_4": {
		"icon": ICON_PATH + "shield_icon.png",
		"displayname": "Shield",
		"details": "Damage reduced increases by 1",
		"level": "Level: 4",
		"prerequesits": ["shield_3"],
		"type": "passive"
	},
	"shield_5": {
		"icon": ICON_PATH + "shield_icon.png",
		"displayname": "Shield",
		"details": "Damage reduced increases by 1",
		"level": "Level: 5",
		"prerequesits": ["shield_4"],
		"type": "passive"
	},
	
	"magnet_1": {
		"icon": ICON_PATH + "magnet_icon.png",
		"displayname": "Magnet",
		"details": "Character picks up items from further away",
		"level": "Level: 1",
		"prerequesits": [],
		"type": "passive"
	},
	"magnet_2": {
		"icon": ICON_PATH + "magnet_icon.png",
		"displayname": "Magnet",
		"details": "Pickup range increased by 33%",
		"level": "Level: 2",
		"prerequesits": ["magnet_1"],
		"type": "passive"
	},
	"magnet_3": {
		"icon": ICON_PATH + "magnet_icon.png",
		"displayname": "Magnet",
		"details": "Pickup range increased by 25%",
		"level": "Level: 3",
		"prerequesits": ["magnet_2"],
		"type": "passive"
	},
	"magnet_4": {
		"icon": ICON_PATH + "magnet_icon.png",
		"displayname": "Magnet",
		"details": "Pickup range increased by 20%",
		"level": "Level: 4",
		"prerequesits": ["magnet_3"],
		"type": "passive"
	},
	"magnet_5": {
		"icon": ICON_PATH + "magnet_icon.png",
		"displayname": "Magnet",
		"details": "Pickup range increased by 33%",
		"level": "Level: 5",
		"prerequesits": ["magnet_4"],
		"type": "passive"
	},
	
	"food": {
		"icon": ICON_PATH + "food.png",
		"displayname": "Food",
		"details": "Restores 10 health",
		"level": "N/A",
		"prerequesits": [],
		"type": "item"
	}
}
