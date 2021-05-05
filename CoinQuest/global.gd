extends Node

var levelScoreMet = [false, false, false, false, false, false, false]
var bonusLevelCheck = levelScoreMet.slice(1,-1,1,false)
var bonusLevelUnlocked = false
var bonusLevelCompleted = false

var bonusEffects = true

var curScene = ""
var lastScene = ""

var levelCompleted = 0

const FILE_NAME = "user://game-data.json"

var sav = {
	"levelScoreMet": levelScoreMet,
	"bonusLevelCheck": bonusLevelCheck,
	"bonusLevelUnlocked": bonusLevelUnlocked,
	"bonusLevelCompleted": bonusLevelCompleted,
	"bonusEffects": bonusEffects,
	"levelCompleted": levelCompleted
}

func save():
	sav.levelScoreMet = levelScoreMet
	sav.bonusLevelCheck =bonusLevelCheck
	sav.bonusLevelUnlocked = bonusLevelUnlocked
	sav.bonusLevelCompleted = bonusLevelCompleted
	sav.bonusEffects = bonusEffects
	sav.levelCompleted = levelCompleted
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(sav))
	file.close()

func load_save():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			sav = data
		else:
			return false
# warning-ignore:unreachable_code
			printerr("Corrupted data!")
	else:
		return false
		printerr("No saved data!")
	return true
