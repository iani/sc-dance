class_name SCRokokoOscParser
extends RefCounted

## A dictionary containing all received messages.
var incoming_messages := {}

func parse(packet: PackedByteArray) -> Dictionary:
	# print(packet)
	if packet.get_string_from_ascii() == "#bundle":
		parse_bundle(packet)
	else:
		parse_message(packet)

	return incoming_messages

func parse_message(packet: PackedByteArray) -> void:
	# print(packet)
	var comma_index = packet.find(44)
	var address = packet.slice(0, comma_index).get_string_from_ascii() as StringName
	var args = packet.slice(comma_index, packet.size())
	var tags = args.get_string_from_ascii()
	var vals = []

	args = args.slice(ceili((tags.length() + 1) / 4.0) * 4, args.size())

	for tag in tags.to_ascii_buffer():
		# print(tags)
		match tag:
			44: #,: comma
				pass
			70: #false
				vals.append(false)
			84: #true
				vals.append(true)
			105: #i: int32
				var val = args.slice(0, 4)
				val.reverse()
				vals.append(val.decode_s32(0))
				args = args.slice(4, args.size())
			102: #f: float32
				var val = args.slice(0, 4)
				val.reverse()
				vals.append(val.decode_float(0))
				args = args.slice(4, args.size())
			115: #s: string
				var val = args.get_string_from_ascii()
				vals.append(val)
				args = args.slice(ceili((val.length() + 1) / 4.0) * 4, args.size())
			98:  #b: blob
				vals.append(args)

	incoming_messages[address] = vals

	if vals is Array and len(vals) == 1:
		vals = vals[0]

	# message_received.emit(address, vals, Time.get_time_string_from_system())
	# print(address, vals)
	# return [address, vals]

#Handle and parse incoming bundles
func parse_bundle(packet: PackedByteArray)  -> void:
	#print(packet)
	packet = packet.slice(7)
	var mess_num = []
	var bund_ind = 0
	var messages = []

	# Find beginning of messages in bundle
	for i in range(packet.size()/4.0):
		var bund_arr = PackedByteArray([32,0,0,0])
		var testo = ""
		if packet.slice(i*4, i*4+4) == PackedByteArray([1, 0, 0, 0]):
			mess_num.append(i*4)
			bund_ind + 1

		elif packet[i*4+1] == 47 and packet[i*4 - 2] <= 0 and packet.slice(i*4 - 4, i*4) != PackedByteArray([1, 0, 0, 0]):
			mess_num.append(i*4-4)


		pass

	# Add messages to an array
	for i in range(len(mess_num)):

		if i  < len(mess_num) - 1:
			messages.append(packet.slice(mess_num[i]+4, mess_num[i+1]+1))
		else:
			var pack = packet.slice(mess_num[i]+4)

			messages.append(pack)

	# Iterate and parse the messages
	for bund_packet in messages:

		bund_packet.remove_at(0)
		bund_packet.insert(0,0)
		#print(bund_packet)
		var comma_index = bund_packet.find(44)
		var address = bund_packet.slice(1, comma_index).get_string_from_ascii() as StringName
		var args = bund_packet.slice(comma_index, packet.size())
		var tags = args.get_string_from_ascii()
		var vals = []


		args = args.slice(ceili((tags.length() + 1) / 4.0) * 4, args.size())

		for tag in tags.to_ascii_buffer():
			#print(tags)
			match tag:
				44: #,: comma
					pass
				70: #false
					vals.append(false)
					args = args.slice(4, args.size())
				84: #true
					vals.append(true)
					args = args.slice(4, args.size())
				105: #i: int32
					var val = args.slice(0, 4)
					val.reverse()
					vals.append(val.decode_s32(0))
					args = args.slice(4, args.size())
				102: #f: float32
					var val = args.slice(0, 4)
					val.reverse()
					vals.append(val.decode_float(0))
					args = args.slice(4, args.size())
				115: #s: string
					var val = args.get_string_from_ascii()
					vals.append(val)
					args = args.slice(ceili((val.length() + 1) / 4.0) * 4, args.size())
				98:  #b: blob
					vals.append(args)


		# print(address, " ", vals)
		incoming_messages[address] = vals
		# message_received.emit(address, vals, Time.get_time_string_from_system())
		print("bundle", [address, vals])
		# return [address, vals]
