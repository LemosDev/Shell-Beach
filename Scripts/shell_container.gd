extends HBoxContainer

@onready var shell_label: Label = $shell_label


func update_shell(amount: int):
	shell_label.text = "%d" % amount
