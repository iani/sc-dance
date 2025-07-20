# class_name SCRokokoTrackerGlobal
extends Node


## SC Rokoko Plugin Node
##
## This node provides a Rokoko tracker as a plugin autoload singleton.


# Tracker source
var _source : SCRokokoSource


# On entering the scene-tree, construct the tracker source and start listening
# for incoming packets.
func _enter_tree() -> void:
	print("_enter_tree SCRokokoTrackerGlobal")
	# Get the face tracker name
	var face_tracker_name : String = ProjectSettings.get_setting(
		"sc_rokoko_tracker/tracking/face_tracker_name",
		GodSCRokokoTrackerPlugin.FACE_TRACKER_NAME_DEFAULT)

	# Get the body tracker name
	var body_tracker_name : String = ProjectSettings.get_setting(
		"sc_rokoko_tracker/tracking/body_tracker_name",
		GodSCRokokoTrackerPlugin.BODY_TRACKER_NAME_DEFAULT)

	# Get the position mode
	var position_mode = ProjectSettings.get_setting(
		"sc_rokoko_tracker/tracking/position_mode",
		GodSCRokokoTrackerPlugin.POSITION_MODE_DEFAULT)

	# Get the UDP port number
	var udp_listener_port : int = ProjectSettings.get_setting(
		"sc_rokoko_tracker/network/udp_listener_port",
		GodSCRokokoTrackerPlugin.OSC_PORT_DEFAULT)

	_source = SCRokokoSource.new(
		face_tracker_name,
		body_tracker_name,
		position_mode,
		udp_listener_port)


# On frame processing, poll the tracker source for updates.
func _process(_delta: float) -> void:
	_source.poll()
