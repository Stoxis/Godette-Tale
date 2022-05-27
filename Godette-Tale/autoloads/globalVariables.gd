extends Node

onready var currentRoom : String
var Name : String = "EMPTY"
var Love : int = 0
var Gold : int = 0
var PlayerAT : int = 0
var PlayerDF : int = 0
var inventorySize : int = 8
var Items : Array = []
var ItemBoxA : Array = []
var ItemBoxB : Array = []
var previousTime : int = 0
var previousTimeFormatted : String = "0:00"
var roomDescription : String = "--"
var currentRoomDesc : String = "--"
var save_path = "user://save.dat"

var time_start = 0
var time_now = 0

var activationList : Dictionary
var objectList : Dictionary

var cellList : PoolStringArray
var talkList : PoolStringArray
var shopInventory : Array

var exitShopPosition : Vector2
var exitShopScene : String
var exitingShop : bool = false

var tie : Node
var dialogue : Node

var menuOpen : bool = false
var disableMenu : bool = false #Enable this if you want to disable the ability to open the menu, if it's already opened this only disables subsequent openings.

func _ready():
	time_start = OS.get_unix_time()
	funcLoad()
	print(Items)

func _process(delta):
	time_now = OS.get_unix_time()
	var _time_elapsed = (time_now + previousTime) - time_start
	#print(str(floor(time_elapsed / 60)) + ":" + '%02d' % (time_elapsed % 60))

func funcSave():
	var time_elapsed = (time_now + previousTime) - time_start
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		if Love == 0:
			Name = "Chara"
			Love = 1
		file.store_var(Name)
		file.store_var(Love)
		file.store_var(Gold)
		file.store_var(Items)
		file.store_var(ItemBoxA)
		file.store_var(ItemBoxB)
		file.store_var(time_elapsed)
		file.store_var(str(get_tree().current_scene.filename))
		file.store_var(currentRoomDesc)
		file.store_var($"/root/Root_Node/Player".get_position())
		if activationList.size() != 0 && objectList.size() != 0:
			print("saved")
			file.store_var(activationList)
			file.store_var(objectList)
		file.close()
		previousTimeFormatted = str(floor(time_elapsed / 60)) + ":" + '%02d' % (time_elapsed % 60)
		roomDescription = currentRoomDesc
		signalManager.emit_signal("save_update")

func funcLoad():
	var file = File.new()
	var activationListTemp
	var objectListTemp
	var savedRoom : String
	var savedPosition : Vector2 = Vector2(0,0)
	if file.file_exists(save_path):
		var error = file.open(save_path, file.READ)
		if error == OK:
			Name = file.get_var()
			Love = file.get_var()
			Gold = file.get_var()
			Items = file.get_var()
			ItemBoxA = file.get_var()
			ItemBoxB = file.get_var()
			previousTime = file.get_var()
			savedRoom = file.get_var()
			roomDescription = file.get_var()
			savedPosition = file.get_var()
			activationListTemp = file.get_var()
			objectListTemp = file.get_var()
			if str(activationListTemp) != "Null":
				if activationListTemp.size() != 0:
					activationList = activationListTemp
					objectList = objectListTemp
			file.close()
			previousTimeFormatted = str(floor(previousTime / 60)) + ":" + '%02d' % (previousTime % 60)
			signalManager.emit_signal("save_update")
			SceneChanger.change_scene_fast(savedRoom, savedPosition)
