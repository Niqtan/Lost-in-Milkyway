extends Node

# Give a starting dark 
var dark_matter: int = 150

# Signal for alerting the bar UI if dark matter has been changed
signal dark_matter_changed(new_amount)


func spend_dark_matter(amount: int) -> void:
	dark_matter -= amount
	dark_matter_changed.emit(dark_matter)
	print("You spent some dark matter. New balance: ", dark_matter)
	
func add_dark_matter(amount: int) -> void:
	dark_matter += amount
	dark_matter_changed.emit(dark_matter)
	print("Added some dark matter. New balance: ", dark_matter)
	
func reset_dark_matter() -> void:
	dark_matter = 150
	dark_matter_changed.emit(dark_matter)
