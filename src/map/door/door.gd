extends Node2D
class_name Door

export var id := ""
export var dest_door_id := ""
export (String, FILE, "*.tscn") var room : String
export var to_indoors := false

func exit_through():
	#la idea es:
	#hacer un fade out y esperar que termine
#	Fade.out_bright(0.25)
#	yield(Fade,"finished")

	#sacar al jugador de la escena
	#cambiar de escena
	#agregar al jugador a la escena
	#posicionar al jugador en la puerta target
	var darkness_level = 3 if to_indoors else -3
	Fade.fade_and_come_back(darkness_level, 0.3, 0.1, 0.3)
	yield(Fade, "fade_out_completed")
	RoomGlobal.goto_room(room, dest_door_id)
	
	#animar al jugador caminando para adelante
	#hacer un fade in y esperar que termine
	#dejar de animar al jugador y sacarle invulnerabilidad
	pass

func come_through(character):
	pass
