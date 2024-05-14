## UIKid (Autoload Singleton)
##
## Provides common functions for working with UI control nodes in Godot Engine.
## Autoload's when UIKid plugin is enabled.
##
## See the README.md file for detailed usage instructions and examples.

@tool
extends Node

## is this script running in the editor or a game window
##
## * return bool - true if edited_scene_root
##                 contains a node which would only
##                 be the case in an editor window
func is_editor() -> bool:
	return get_tree().edited_scene_root != null


## determine the viewport size using either the root viewport
## of the current scene tree or the viewport size based on the
## window size defined in project settings
##
## * return Vector2i - viewport size
func root_viewport_size() -> Vector2i:
	if is_editor():
		# Running in the editor, use Project Settings for sizing. 
		var y = ProjectSettings.get("display/window/size/viewport_height")
		var x = ProjectSettings.get("display/window/size/viewport_width")
		return Vector2i(x, y)
	else:
		# Running in-game, use root viewport for sizing.
		return get_tree().get_root().size
