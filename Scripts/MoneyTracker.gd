extends Node

class_name MoneyTracker

@export
var money_in_cents: int
@export
var minimum_money: int
@export
var moneyDisplay: TextEdit

# Constructor
func _init() -> void:
	money_in_cents = 1
	minimum_money = 1


func TakeMoney(money: int):
	"""Take a certain amount of money, measured in cents."""
	if money > money_in_cents:
		return 0
	else:
		money_in_cents -= money
		return money


func GetMoney(money: int):
	print("Got " + str(money) + "cents!")
	money_in_cents += money


func GetMoneyText():
	var moneyText: String
	moneyText = "$"
	moneyText += str(money_in_cents/100)
	if money_in_cents % 100 != 0:
		moneyText += "."
		var cents: int = money_in_cents % 100
		if cents < 10:
			moneyText += "0"
		moneyText += str(cents)
	return moneyText


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	moneyDisplay.text = "Money: " + self.GetMoneyText()
	pass
