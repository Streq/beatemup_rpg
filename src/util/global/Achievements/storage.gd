extends Node

var SAVE_PATH := "user://achievements.save"


func load_from_file():
	var save_game : File = File.new()
	
	if save_game.open(SAVE_PATH, File.READ) == 0:
			
		var save = save_game.get_var()
		if !save:
			return
		for achievement in owner.map.values():
			if save.has(achievement.name):
				var val = save[achievement.name]
				achievement.completed = val
				print(achievement.name," ",achievement.completed)
	save_game.close()

func clear():
	owner.clear()
	
	

func save_to_file():
	var save_game = File.new()
	save_game.open(SAVE_PATH, File.WRITE)
	
	var save = {}
	
	for achievement in owner.map.values():
		var val = achievement.completed
		save[achievement.name] = val
	
	save_game.store_var(save)
	save_game.close()
