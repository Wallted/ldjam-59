extends Node

enum ChoristerEnum {
	CHORIPRACTER,
	SINOCEROS,
	QUDRATOPPATOR,
	OGGAZELE,
	DELAILER,
	TIGEREVERBER
}
	
var ChoristerMap = {
	ChoristerEnum.CHORIPRACTER: Choripracter,
	ChoristerEnum.SINOCEROS: Sinoceros,
	ChoristerEnum.QUDRATOPPATOR: Qudratoppator,
	ChoristerEnum.OGGAZELE: Oggazele,
	ChoristerEnum.DELAILER: Delailer,
	ChoristerEnum.TIGEREVERBER: Tigereverber
}

var ChoristerResMap = {
	ChoristerEnum.CHORIPRACTER:  preload("res://icon.svg"),
	ChoristerEnum.SINOCEROS:  preload("res://icon.svg"),
	ChoristerEnum.QUDRATOPPATOR:  preload("res://icon.svg"),
	ChoristerEnum.OGGAZELE:  preload("res://icon.svg"),
	ChoristerEnum.DELAILER:  preload("res://icon.svg"),
	ChoristerEnum.TIGEREVERBER:  preload("res://icon.svg")
}
