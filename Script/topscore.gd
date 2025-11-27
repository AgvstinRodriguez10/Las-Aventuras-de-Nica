extends CanvasLayer
var savedScores: Dictionary
var rank: int = 1
var fileurl = "res://my_score.txt"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var scoreFile = FileAccess.open("user://my_score_file.txt", FileAccess.READ)
	var scoreFile = FileAccess.open(fileurl, FileAccess.READ)
	if scoreFile.get_as_text() != "":
		savedScores = JSON.parse_string(scoreFile.get_as_text())
	scoreFile.close()
	printRanking()

func printRanking():
	var final = sortRanking(savedScores)
	if final:
		for score in final:
			if rank <= 5:
				$Panel/Ranking/Rank.text += str(rank) + "\n"
				$Panel/Ranking/Name.text += score.nombre + "\n"
				$Panel/Ranking/Score.text += str(int(score.puntaje)) + "\n"
				rank = rank + 1

func sortRanking(unordenRank:Dictionary) -> Array:
	#var json_text = FileAccess.get_file_as_string("res://ranking.json")
	var data = savedScores
	if data:
		data["ranking"].sort_custom(func(a, b):
			return a["puntaje"] > b["puntaje"]
		)

		return data["ranking"]
	else:
		return []
