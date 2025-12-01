class_name ManualAberto extends ObjetoInspecionavel

@export var pagesArray : Array[MeshInstance3D]

var pageIndex : int = 0:
	set(value):
		pageIndex = clampi(value, 0, pagesArray.size() - 1)
		AtualizaPaginaAtual()

func StartInspection(_player : Player):
	pageIndex = 0
	LevelManager.InspectionStarted()
	super.StartInspection(_player)

func LeftPressed():
	pageIndex -= 1

func RightPressed():
	pageIndex += 1

func AtualizaPaginaAtual():
	for i in pagesArray.size():
		pagesArray[i].visible = i >= pageIndex

func StopInspection():
	LevelManager.ManualRead()
	super.StopInspection()
