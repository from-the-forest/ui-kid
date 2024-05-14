## UIKid (Plugin)
##
## Provides common functions for working with UI control nodes in Godot Engine.
## Autoload's when UIKid plugin is enabled.
##
## See the README.md file for detailed usage instructions and examples.

@tool
extends EditorPlugin


func _enter_tree():
	# Initialization plugin autoloads
	add_autoload_singleton("UI", "res://addons/ui_kid/ui_kid.gd")

	# Initialize plugin custom nodes
	add_custom_type("AutoViewportSize", "MarginContainer", preload("res://addons/ui_kid/auto_viewport_size/auto_viewport_size.gd"), preload("res://addons/ui_kid/auto_viewport_size/auto_viewport_size.svg"))


func _exit_tree():
	# Clean-up the plugin custom nodes
	remove_custom_type("AutoViewportSize")

	# Clean-up the plugin autoloads
	remove_autoload_singleton("UI")
