@tool
# @tool in order to also run in the Editor to prevent the warnings
extends Skeleton3D

@export var disabled_bones_warning := true:
	set(value):
		disabled_bones_warning =  value
		update_configuration_warnings()

# these are hard-coded bones in xr_body_medifier_3d.cpp:
var xr_bones_all: Array[String] = [
		"Root", # XRBodyTracker::JOINT_ROOT

		# Upper Body Joints.
		"Hips", # XRBodyTracker::JOINT_HIPS
		"Spine", # XRBodyTracker::JOINT_SPINE
		"Chest", # XRBodyTracker::JOINT_CHEST
		"UpperChest", # XRBodyTracker::JOINT_UPPER_CHEST
		"Neck", # XRBodyTracker::JOINT_NECK"
		"Head", # XRBodyTracker::JOINT_HEAD"
		"HeadTip", # XRBodyTracker::JOINT_HEAD_TIP"
		"LeftShoulder", # XRBodyTracker::JOINT_LEFT_SHOULDER"
		"LeftUpperArm", # XRBodyTracker::JOINT_LEFT_UPPER_ARM"
		"LeftLowerArm", # XRBodyTracker::JOINT_LEFT_LOWER_ARM"
		"RightShoulder", # XRBodyTracker::JOINT_RIGHT_SHOULDER"
		"RightUpperArm", # XRBodyTracker::JOINT_RIGHT_UPPER_ARM"
		"RightLowerArm", # XRBodyTracker::JOINT_RIGHT_LOWER_ARM"

		# Lower Body Joints.
		"LeftUpperLeg", # XRBodyTracker::JOINT_LEFT_UPPER_LEG
		"LeftLowerLeg", # XRBodyTracker::JOINT_LEFT_LOWER_LEG

		# "LeftFoot", # XRBodyTracker::JOINT_LEFT_FOOT
		"LeftAnkle", # XRBodyTracker::JOINT_LEFT_FOOT

		"LeftToes", # XRBodyTracker::JOINT_LEFT_TOES
		"RightUpperLeg", # XRBodyTracker::JOINT_RIGHT_UPPER_LEG
		"RightLowerLeg", # XRBodyTracker::JOINT_RIGHT_LOWER_LEG

		# "RightFoot", # XRBodyTracker::JOINT_RIGHT_FOOT
		"RightAnkle", # XRBodyTracker::JOINT_RIGHT_FOOT

		"RightToes", # XRBodyTracker::JOINT_RIGHT_TOES

		# Left Hand Joints.
		"LeftHand", # XRBodyTracker::JOINT_LEFT_HAND
		"LeftPalm", # XRBodyTracker::JOINT_LEFT_PALM
		"LeftWrist", # XRBodyTracker::JOINT_LEFT_WRIST
		"LeftThumbMetacarpal", # XRBodyTracker::JOINT_LEFT_THUMB_METACARPAL
		"LeftThumbProximal", # XRBodyTracker::JOINT_LEFT_THUMB_PHALANX_PROXIMAL
		"LeftThumbDistal", # XRBodyTracker::JOINT_LEFT_THUMB_PHALANX_DISTAL
		"LeftThumbTip", # XRBodyTracker::JOINT_LEFT_THUMB_TIP
		"LeftIndexMetacarpal", # XRBodyTracker::JOINT_LEFT_INDEX_FINGER_METACARPAL
		"LeftIndexProximal", # XRBodyTracker::JOINT_LEFT_INDEX_FINGER_PHALANX_PROXIMAL
		"LeftIndexIntermediate", # XRBodyTracker::JOINT_LEFT_INDEX_FINGER_PHALANX_INTERMEDIATE
		"LeftIndexDistal", # XRBodyTracker::JOINT_LEFT_INDEX_FINGER_PHALANX_DISTAL
		"LeftIndexTip", # XRBodyTracker::JOINT_LEFT_INDEX_FINGER_TIP
		"LeftMiddleMetacarpal", # XRBodyTracker::JOINT_LEFT_MIDDLE_FINGER_METACARPAL
		"LeftMiddleProximal", # XRBodyTracker::JOINT_LEFT_MIDDLE_FINGER_PHALANX_PROXIMAL
		"LeftMiddleIntermediate", # XRBodyTracker::JOINT_LEFT_MIDDLE_FINGER_PHALANX_INTERMEDIATE
		"LeftMiddleDistal", # XRBodyTracker::JOINT_LEFT_MIDDLE_FINGER_PHALANX_DISTAL
		"LeftMiddleTip", # XRBodyTracker::JOINT_LEFT_MIDDLE_FINGER_TIP
		"LeftRingMetacarpal", # XRBodyTracker::JOINT_LEFT_RING_FINGER_METACARPAL
		"LeftRingProximal", # XRBodyTracker::JOINT_LEFT_RING_FINGER_PHALANX_PROXIMAL
		"LeftRingIntermediate", # XRBodyTracker::JOINT_LEFT_RING_FINGER_PHALANX_INTERMEDIATE
		"LeftRingDistal", # XRBodyTracker::JOINT_LEFT_RING_FINGER_PHALANX_DISTAL
		"LeftRingTip", # XRBodyTracker::JOINT_LEFT_RING_FINGER_TIP
		"LeftLittleMetacarpal", # XRBodyTracker::JOINT_LEFT_PINKY_FINGER_METACARPAL
		"LeftLittleProximal", # XRBodyTracker::JOINT_LEFT_PINKY_FINGER_PHALANX_PROXIMAL
		"LeftLittleIntermediate", # XRBodyTracker::JOINT_LEFT_PINKY_FINGER_PHALANX_INTERMEDIATE
		"LeftLittleDistal", # XRBodyTracker::JOINT_LEFT_PINKY_FINGER_PHALANX_DISTAL
		"LeftLittleTip", # XRBodyTracker::JOINT_LEFT_PINKY_FINGER_TIP

		# Right Hand Joints.
		"RightHand", # XRBodyTracker::JOINT_RIGHT_HAND
		"RightPalm", # XRBodyTracker::JOINT_RIGHT_PALM
		"RightWrist", # XRBodyTracker::JOINT_RIGHT_WRIST
		"RightThumbMetacarpal", # XRBodyTracker::JOINT_RIGHT_THUMB_METACARPAL
		"RightThumbProximal", # XRBodyTracker::JOINT_RIGHT_THUMB_PHALANX_PROXIMAL
		"RightThumbDistal", # XRBodyTracker::JOINT_RIGHT_THUMB_PHALANX_DISTAL
		"RightThumbTip", # XRBodyTracker::JOINT_RIGHT_THUMB_TIP
		"RightIndexMetacarpal", # XRBodyTracker::JOINT_RIGHT_INDEX_FINGER_METACARPAL
		"RightIndexProximal", # XRBodyTracker::JOINT_RIGHT_INDEX_FINGER_PHALANX_PROXIMAL
		"RightIndexIntermediate", # XRBodyTracker::JOINT_RIGHT_INDEX_FINGER_PHALANX_INTERMEDIATE
		"RightIndexDistal", # XRBodyTracker::JOINT_RIGHT_INDEX_FINGER_PHALANX_DISTAL
		"RightIndexTip", # XRBodyTracker::JOINT_RIGHT_INDEX_FINGER_TIP
		"RightMiddleMetacarpal", # XRBodyTracker::JOINT_RIGHT_MIDDLE_FINGER_METACARPAL
		"RightMiddleProximal", # XRBodyTracker::JOINT_RIGHT_MIDDLE_FINGER_PHALANX_PROXIMAL
		"RightMiddleIntermediate", # XRBodyTracker::JOINT_RIGHT_MIDDLE_FINGER_PHALANX_INTERMEDIATE
		"RightMiddleDistal", # XRBodyTracker::JOINT_RIGHT_MIDDLE_FINGER_PHALANX_DISTAL
		"RightMiddleTip", # XRBodyTracker::JOINT_RIGHT_MIDDLE_FINGER_TIP
		"RightRingMetacarpal", # XRBodyTracker::JOINT_RIGHT_RING_FINGER_METACARPAL
		"RightRingProximal", # XRBodyTracker::JOINT_RIGHT_RING_FINGER_PHALANX_PROXIMAL
		"RightRingIntermediate", # XRBodyTracker::JOINT_RIGHT_RING_FINGER_PHALANX_INTERMEDIATE
		"RightRingDistal", # XRBodyTracker::JOINT_RIGHT_RING_FINGER_PHALANX_DISTAL
		"RightRingTip", # XRBodyTracker::JOINT_RIGHT_RING_FINGER_TIP
		"RightLittleMetacarpal", # XRBodyTracker::JOINT_RIGHT_PINKY_FINGER_METACARPAL
		"RightLittleProximal", # XRBodyTracker::JOINT_RIGHT_PINKY_FINGER_PHALANX_PROXIMAL
		"RightLittleIntermediate", # XRBodyTracker::JOINT_RIGHT_PINKY_FINGER_PHALANX_INTERMEDIATE
		"RightLittleDistal", # XRBodyTracker::JOINT_RIGHT_PINKY_FINGER_PHALANX_DISTAL
		"RightLittleTip", # XRBodyTracker::JOINT_RIGHT_PINKY_FINGER_TIP

		# Extra Joints.
		"LowerChest", # XRBodyTracker::JOINT_LOWER_CHEST
		"LeftScapula", # XRBodyTracker::JOINT_LEFT_SCAPULA
		"LeftWristTwist", # XRBodyTracker::JOINT_LEFT_WRIST_TWIST
		"RightScapula", # XRBodyTracker::JOINT_RIGHT_SCAPULA
		"RightWristTwist", # XRBodyTracker::JOINT_RIGHT_WRIST_TWIST

		# "LeftFootTwist", # XRBodyTracker::JOINT_LEFT_FOOT_TWIST
		"LeftAnkleTwist", # XRBodyTracker::JOINT_LEFT_FOOT_TWIST

		"LeftHeel", # XRBodyTracker::JOINT_LEFT_HEEL
		"LeftMiddleFoot", # XRBodyTracker::JOINT_LEFT_MIDDLE_FOOT

		# "RightFootTwist", # XRBodyTracker::JOINT_RIGHT_FOOT_TWIST
		"RightAnkleTwist", # XRBodyTracker::JOINT_RIGHT_FOOT_TWIST

		"RightHeel", # XRBodyTracker::JOINT_RIGHT_HEEL
		"RightMiddleFoot", # XRBodyTracker::JOINT_RIGHT_MIDDLE_FOOT
	]

var bones_disabled: Dictionary[String, int]

func add_missing_xr_bones() -> void:
	for bone in xr_bones_all:
		if find_bone(bone) == -1:
			var bone_index = add_bone(bone)
			set_bone_enabled(bone_index, false)
			# print("added fake bone: %s as index: %s" % [bone, bone_index])
			bones_disabled.set(bone, bone_index)
	if ! bones_disabled.is_empty():
		var sub_path = owner.get_parent().get_path_to(self)
		print_rich("[color=ORANGE][indent]** Added missing bones expected by XRBodyModifier3D to %s\n%s" % [sub_path, bones_disabled])


func _init() -> void:
	#print("_int: %s" % self)	
	## NOTE: cannot check for presence of XRBodyModifier3D this early!
	# print("children: %s" % [get_children()])
	add_missing_xr_bones()

func _get_configuration_warnings() -> PackedStringArray:
	#print("_get_configuration_warnings: %s" % self)
	# print("children: %s" % [get_children()])
	var warnings: PackedStringArray
	# var warnings: String
	if disabled_bones_warning and bones_disabled.is_empty():
		for i in get_bone_count():
			if ! is_bone_enabled(i):
				bones_disabled.set(get_bone_name(i), i)
		if ! bones_disabled.is_empty():
			#v ar scene_root = get_tree().current_scene ## returns null value
			# var scene_root = child_node.owner ## returns Armature
			var scene_root = self.owner.get_parent() ## correct — but is it relyable?			
			# var scene_root = get_tree().root
			# var scene_root = get_tree_string()
			#print("current_scene: %s" % scene_root)
			
			var path_from_scene_root = scene_root.get_path_to(self)
			#print("path_from_scene_root: %s" % path_from_scene_root)
			warnings.append("Disabled Bones Warning 'On' — {0} at '[...]{1}' has these bones disabled:\n{2}" \
				.format([self, path_from_scene_root, bones_disabled]))
			# warnings = "This Skeleton3D node has disabled bones:\n{0}".format([bones_disabled])
			for node in get_children():
				if node is XRBodyModifier3D:
					warnings.append("XRBodyModifier3D is present as a child node. This means that the disabled bones were most likely automatically added and then disabled by the attached script in order to prevent the disturbing xr_body_modifier_3d.cpp warnings.")
					# warnings ++= "XRBodyModifier3D is present as a child node. This means that the disabled bones were most likely automatically added and then disabled by the attached script in order to prevent the disturbing xr_body_modifier_3d.cpp warnings."
					break 
		for warning in warnings:
			print_rich("[color=BURLYWOOD][indent]** %s" % warning)
		# print("_get_configuration_warnings: %s" % warnings)
		# print("_get_configuration_warnings: %s" % bones_disabled)
	## NOTE: avoid the red exclamation mark by only returning a single element array
	# return warnings
	if warnings.size() > 0:
		return ["\n".join(warnings)]
	else: 
		return []

 ## NOTE: In order to have this virtual method run,
 ## enable Editor > Editor Settings > Dock > Scene Tree > Accessabilty Warnings
#func _get_accessibility_configuration_warnings() -> PackedStringArray:
	#print("_get_accessibility_configuration_warnings: %s" % self)
	#var warnings: PackedStringArray
	### ## NOTE: One warning puts a yellow triangle on the node:
	#warnings.append("_get_accessibility_configuration_warnings")
	### ## ΝΟΤΕ: The second warning also adds a red exclamation mark:
	#warnings.append("_get_accessibility_configuration_warnings")
	#return warnings

#func _get_configuration_warnings() -> PackedStringArray:
	#print("_get_configuration_warnings: %s" % self)
	#var warnings: PackedStringArray
	## ## NOTE: One warning puts a yellow triangle on the node:
	#warnings.append("_get_configuration_warnings")
	## ## ΝΟΤΕ: The second warning also adds a red exclamation mark:
	#warnings.append("_get_configuration_warnings")
	#return warnings

# ## Trying to override the func called from XRBodyModifier3D failed as warned about:
#func find_bone(bbb: String) -> int:
	#print("find_bone name: %" % bbb)
	#return 1
