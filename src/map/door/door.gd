extends Node2D
class_name Door

export var id := 0
export var dest_door_id := 0
export (String, FILE, "*room.tscn") var room : String


func trigger():
	#la idea es:
	#hacer un fade out y esperar que termine
#	Fade.out_bright(0.25)
#	yield(Fade,"finished")

	#sacar al jugador de la escena
	#cambiar de escena
	#agregar al jugador a la escena
	#posicionar al jugador en la puerta target
	yield(Fade.fade_to_darkness_level(-3,1.0),"finished")

	RoomGlobal.goto_room(room, dest_door_id)
	
	#animar al jugador caminando para adelante
	#hacer un fade in y esperar que termine
	#dejar de animar al jugador y sacarle invulnerabilidad
	pass
