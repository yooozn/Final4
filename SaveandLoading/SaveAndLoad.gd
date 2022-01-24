extends Node

var save_path = "user://save.dat"
var room = "res://Spark Forest.tscn"
var collectible = 20
var playerPos = Vector2(0,0)
var cutscene = false
var bossfight = false

func _Save():
	#Variable data which is a dictionary to store all data. All values will be changed throughout different scenes, and scripts
	#and saved via the SaveandLoad._Save() method(Can be used globally). This method saves the following data shown below.
	var data = {
		"1" : room,
		"2" : playerPos,
		"3" : "three",
		"4" : "four",
		"5" : "five",
		"6" : "six"
	}
	#Opens file, unless there is an error.
	var file = File.new()
	var error = file.open(save_path,File.WRITE)
	if error == OK: 
		file.store_var(data)
		file.close()

func _newGame():
	#Starts a fresh dictionary data, and wipes old data
	var data = {
		"1" : "res://Spark Forest.tscn",
		"2" : "two",
		"3" : "three",
		"4" : "four",
		"5" : "five",
		"6" : "six"
	}
	var file = File.new()
	var error = file.open(save_path,File.WRITE)
	if error == OK: 
		file.store_var(data)
		file.close()
		#Transitions to spark forest when called(level 1)
	get_tree().change_scene("res://Spark Forest.tscn")
	
func _Load():
	#Loads previously saved data
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data = file.get_var()
			file.close()
			#Sets the local room and player pos variables to the corresponding keys previously saved in the dictionary
			room = player_data["1"]
			playerPos = player_data["2"]
			#Sets player spawn location to previously set spawn position
			Globals.player_initial_map_position = playerPos
			get_tree().change_scene(room)
			print(player_data["1"])


func _on_Timer_timeout():
	if cutscene == false and bossfight == false and Globals.player.is_on_floor() == true:
		playerPos = Globals.player.position
		_Save()
