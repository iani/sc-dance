@tool
extends EditorPlugin


func _define_project_setting(
		p_name : String,
		p_type : int,
		p_hint : int = PROPERTY_HINT_NONE,
		p_hint_string : String = "",
		p_default_val = "") -> void:
	# p_default_val can be any type!!

	if !ProjectSettings.has_setting(p_name):
		ProjectSettings.set_setting(p_name, p_default_val)

	var property_info : Dictionary = {
		"name" : p_name,
		"type" : p_type,
		"hint" : p_hint,
		"hint_string" : p_hint_string
	}

	ProjectSettings.add_property_info(property_info)
	if ProjectSettings.has_method("set_as_basic"):
		ProjectSettings.call("set_as_basic", p_name, true)
	ProjectSettings.set_initial_value(p_name, p_default_val)



func _enter_tree():
	print("_enter_tree rokoko EditorPlugin")
	# Add face tracker name
	_define_project_setting(
			"rokoko_tracker/tracking/face_tracker_name",
			TYPE_STRING,
			PROPERTY_HINT_NONE,
			"",
			"/rokoko/face_tracker")

	# Add body tracker name
	_define_project_setting(
			"rokoko_tracker/tracking/body_tracker_name",
			TYPE_STRING,
			PROPERTY_HINT_NONE,
			"",
			"/rokoko/body_tracker")

	# Add position mode
	_define_project_setting(
			"rokoko_tracker/tracking/position_mode",
			TYPE_INT,
			PROPERTY_HINT_ENUM,
			"Free,Calibrate,Locked",
			0)

	# Add network port
	_define_project_setting(
			"rokoko_tracker/network/udp_listener_port",
			TYPE_INT,
			PROPERTY_HINT_NONE,
			"",
			14043)

	# Register our autoload user settings object
	add_autoload_singleton(
			"RokokoPlugin",
			"res://addons/godot_rokoko_tracker/rokoko_plugin.gd")


func _exit_tree():
	# our plugin is turned off
	pass
