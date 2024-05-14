## AutoViewportSize (MarginContainer)
##
## Resizes the MarginContainer to either the scene tree's root viewport size
## or the project settings window size.
##
## See the README.md file for detailed usage instructions and examples.

@tool
class_name AutoViewportSize
extends MarginContainer

const DEFAULT_UI_OFFSET_TOP: float = 0.0 # absolute top 
const DEFAULT_UI_OFFSET_LEFT: float = 0.0 # absolute left
const DEFAULT_UI_ANCHOR_TOP: float = 0.0 # 0% viewport height
const DEFAULT_UI_ANCHOR_LEFT: float = 0.0 # 0% viewport width
const DEFAULT_UI_ANCHOR_BOTTOM: float = 1.0 # 100% viewport height
const DEFAULT_UI_ANCHOR_RIGHT: float = 1.0 # 100% viewport width

#region Node

func _enter_tree():
	_initialize_ui_anchor_defaults()
	_connect_project_settings_changed()
	_connect_root_viewport_size_changed()

	# configure the default ui container size
	# (enter tree with project window size)
	_update_ui_size.call_deferred()


func _ready():
	_update_ui_size.call_deferred()


func _exit_tree():
	_disconnect_project_settings_changed()
	_disconnect_root_viewport_size_changed()

#endregion

#region configure signals

func _connect_root_viewport_size_changed():
	if not get_tree().get_root().size_changed.is_connected(_update_ui_size):
			get_tree().get_root().size_changed.connect(_update_ui_size)


func _connect_project_settings_changed():
	if not ProjectSettings.settings_changed.is_connected(_update_ui_size):
		ProjectSettings.settings_changed.connect(_update_ui_size)


func _disconnect_root_viewport_size_changed():
	if get_tree().get_root().size_changed.is_connected(_update_ui_size):
			get_tree().get_root().size_changed.disconnect(_update_ui_size)
	

func _disconnect_project_settings_changed():
	if ProjectSettings.settings_changed.is_connected(_update_ui_size):
			ProjectSettings.settings_changed.disconnect(_update_ui_size)

#endregion

#region private


## Handles setting the MarginContainer's offset
## to fill the root viewport size
func _update_ui_size() -> void:
	var size = UI.root_viewport_size()
	offset_bottom = size.y
	offset_right = size.x
	queue_redraw()


## Initialize the MarginContainer's anchor and
## offset values. offset_bottom and offset_right
## are always based on the root viewport size
func _initialize_ui_anchor_defaults() -> void:
	offset_top = DEFAULT_UI_OFFSET_TOP 
	offset_left = DEFAULT_UI_OFFSET_LEFT 
	anchor_top = DEFAULT_UI_ANCHOR_TOP 
	anchor_left = DEFAULT_UI_ANCHOR_LEFT 
	anchor_bottom = DEFAULT_UI_ANCHOR_BOTTOM 
	anchor_right = DEFAULT_UI_ANCHOR_RIGHT 

#endregion
