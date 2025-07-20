class_name SCRokokoOscData
extends RefCounted

# var _data := RokokoBody.BodyData.new()
var data : RokokoBody.BodyData
var vals := []
var slices := []
var i := 0
var idx_max := -i
var mapped_names : Array

func _init():
	mapped_names = RokokoBody.JOINT_NAMES.keys()

func parse(in_vals: Array, ref_data: RokokoBody.BodyData) -> void: # RokokoBody.BodyData:
	# _data = RokokoBody.BodyData.new()
	vals = in_vals
	data = ref_data
	i = 0
	slices = []
	vals.map(make_slices)
	# print(slices)
	idx_max = slices.size() - 1
	i = 0
	slices.map(parse_slices)
	# return _osc_data
	# return _data

func make_slices(elm) -> void:
	# print("elm: %s" % elm)
	if elm is String:  # and (elm as StringName) in mapped_names:
		# print("%s %s" % [i, elm])
		slices.push_back(i)
	i = i + 1

# func make_slices(vals: Array) -> void:
# 	i = 0
# 	vals.map(func(elm):
# 		# print("elm: %s" % elm)
# 		if elm is String:
# 			slices.push_back(i)
# 		# print("%s %s" % [i, elm])
# 		i = i + 1
# 		)

func parse_slices(idx:int) -> void:
	var key = vals[idx] as StringName
	# if key in mapped_names:
	var joint : RokokoBody.Joint = RokokoBody.JOINT_NAMES.get(key, -1)
	if joint >= 0:
		var last_val_idx
		if i == idx_max:
			last_val_idx = vals.size() - 1
		else:
			last_val_idx = slices[i + 1] - 1

		# print(last_val_idx - idx)
		match last_val_idx - idx:
			7:
				var pos = Vector3(
					vals[idx + 1],
					vals[idx + 2],
					-vals[idx + 3]
					)
				var rot = Quaternion(
					vals[idx + 4], vals[idx + 5], -vals[idx + 6], -vals[idx + 7])
				# # print("%s: pos: %s + rot %s" % [key, pos, rot])
				# skel.set_bone_pose_position(joints2indices[key], pos)
				# # skel.set_bone_pose_rotation(joints2indices[key], rot)
				# Set the position and rotation
				data.positions[joint] = pos
				data.rotations[joint] = rot

			3:
				var pos = Vector3(
					vals[idx + 1], vals[idx + 2], -vals[idx + 3])
				print("%s: pos: %s" % [key, pos])
				# skel.set_bone_pose_position(joints2indices[key], pos)
				data.positions[joint] = pos
			4:
				var rot = Quaternion(
					vals[idx + 4], vals[idx + 5], -vals[idx + 6], -vals[idx + 7])
				print("%s: rot %s" % [key, rot])
				# skel.set_bone_pose_rotation(joints2indices[key], rot)
				data.rotations[joint] = rot
			_:
				push_warning("%s OSC data parsing error")
	i = i + 1
