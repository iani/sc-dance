class_name SCRokokoTracker
extends Node


## Rokoko Tracker Node
##
## This node provides a Rokoko tracker as a scene-tree node. It may also
## be instantiated as an autoload to provide for multiple trackers on different
## ports.


## Face tracker name
@export var face_tracker_name : String = GodSCRokokoTrackerPlugin.FACE_TRACKER_NAME_DEFAULT

## Body tracker name
@export var body_tracker_name : String = GodSCRokokoTrackerPlugin.BODY_TRACKER_NAME_DEFAULT

## Position mode
@export_enum("Free", "Calibrate", "Locked") var position_mode : int = GodSCRokokoTrackerPlugin.POSITION_MODE_DEFAULT

## UDP listener port
@export var udp_listener_port : int = GodSCRokokoTrackerPlugin.OSC_PORT_DEFAULT


# Tracker source
var _source : SCRokokoSource


# On entering the scene-tree, construct the tracker source and start listening
# for incoming packets.
func _enter_tree() -> void:
	print("_enter_tree SCRokokoTracker")
	_source = SCRokokoSource.new(
		face_tracker_name,
		body_tracker_name,
		position_mode,
		udp_listener_port)


# On frame processing, poll the tracker source for updates.
func _process(_delta: float) -> void:
	_source.poll()
