extends Node

var save_path = "user://save.dat"
var room = "res://Spark Forest.tscn"
var playerPos = Vector2(0,0)

func _Save():
	#Variable data which is a dictionary to store all data. All values will be changed throughout different scenes, and scripts
	#and saved via the SaveandLoad._Save() method(Can be used globally). This method saves the following data shown below.
	var data = {
		"1" : room,
		"2" : playerPos,
		"3" : "three",
		"4" : "four",
		"5" : "five"
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
		"5" : "five"
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
			room = player_data["1"]
			playerPos = player_data["2"]
			Globals.player_initial_map_position = playerPos
			get_tree().change_scene(room)
			print(player_data["1"])
