extends ColorRect

@onready var label_name = $NameLabel
@onready var label_level = $LevelLabel
@onready var label_description = $DescriptionLabel
@onready var item_icon = $ItemIcon

var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_process"))
	
	if item == null:
		item = "food"
		
	label_name.text = UpgradeDataBase.UPGRADES[item]["displayname"]
	label_description.text = UpgradeDataBase.UPGRADES[item]["details"]
	label_level.text = UpgradeDataBase.UPGRADES[item]["level"]
	item_icon.texture = load(UpgradeDataBase.UPGRADES[item]["icon"])


func _input(event):
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false
