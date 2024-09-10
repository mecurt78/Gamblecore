extends Node

class_name SimpleSlot

@export
var spriteList: Array[Sprite2D] = []
@export
var moneyTracker: MoneyTracker
@export
var centsPerPull: int = 100
@export
var wildFrame = 0
@export
var frameMultipliers: Dictionary = {
	0: 1,
	1: 1,
	2: 0
}
@export
var spriteImages: Array[Texture2D]
@export
var allWildBonus = 1000
@export
var reward = 50
@export
var button: Button


func OnPull():
	if moneyTracker.TakeMoney(centsPerPull) > 0:
		print("Let's go gambling!")
		var frames: Array[int] = []
		# Set random frames.
		for sprite in spriteList:
			randomize()  # Initialize the random number generator
			var random_frame = randi_range(0, spriteImages.size()-1)
			sprite.texture = spriteImages[random_frame]
			frames.append(random_frame)
		# Check for win.
		print("Got the roll: " + str(frames))
		var values: Array[int] = []
		for frame in frames:
			if frame != wildFrame:
				values.append(frameMultipliers[frame])
		print("This is: " + str(values))
		if values.size() == 0:
			# All values were wild. Award wild bonus.
			moneyTracker.GetMoney(allWildBonus)
			return
		else:
			# Got at least one value that isn't the wild.
			var firstValue = values.pop_front()
			if firstValue == 0:
				print("Aah dang it!")
				return
			for value in values:
				if firstValue != value:
					# At least one value doesn't match.
					print("Aah dang it!")
					return
			# If we get here, all values match.
			moneyTracker.GetMoney(reward * firstValue)
			return
	else:
		print("Ah fuck, I'm broke!")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#button.button_pressed = OnPull
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
