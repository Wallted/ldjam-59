extends Node


enum ChoristerEnum {
	CHORIPRACTER,
	SINOCEROS,
	QUDRATOPPATOR,
	OGGAZELE,
	DELAILER,
	TIGEREVERBER,
}
	
var ChoristerMap = {
	ChoristerEnum.CHORIPRACTER: Choripracter,
	ChoristerEnum.SINOCEROS: Sinoceros,
	ChoristerEnum.QUDRATOPPATOR: Qudratoppator,
	ChoristerEnum.OGGAZELE: Oggazele,
	ChoristerEnum.DELAILER: Delailer,
	ChoristerEnum.TIGEREVERBER: Tigereverber,
}

var ChoristerResMap = {
	ChoristerEnum.CHORIPRACTER:  "meowl",
	ChoristerEnum.SINOCEROS:  "wabbit",
	ChoristerEnum.QUDRATOPPATOR:  "deew",
	ChoristerEnum.OGGAZELE: "lambi",
	ChoristerEnum.DELAILER:  "beer",
	ChoristerEnum.TIGEREVERBER:  null,
}

var ChoristerResMapPreload = {}

func _ready() -> void:
	for key in ChoristerEnum.values():
		var res_name = ChoristerResMap[key]
		if res_name != null:
			ChoristerResMapPreload[key] = [
				load("res://assets/animals/%s/idle_0.png" % res_name),
				load("res://assets/animals/%s/idle_1.png" % res_name),
				load("res://assets/animals/%s/sing_0.png" % res_name),
				load("res://assets/animals/%s/sing_1.png" % res_name),
			]
		else:
			ChoristerResMapPreload[key] = [
				load("res://icon.svg"),
				load("res://icon.svg"),
				load("res://icon.svg"),
				load("res://icon.svg"),
			]

# set in audio._ready() xDDD
var ChoristerAudioStreamPlayer = {
	ChoristerEnum.CHORIPRACTER: null,
	ChoristerEnum.SINOCEROS: null,
	ChoristerEnum.QUDRATOPPATOR: null,
	ChoristerEnum.OGGAZELE: null,
	ChoristerEnum.DELAILER: null,
	ChoristerEnum.TIGEREVERBER: null,
}
