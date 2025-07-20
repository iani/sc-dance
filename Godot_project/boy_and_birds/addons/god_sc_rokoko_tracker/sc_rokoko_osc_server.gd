class_name SCRokokoOscServer
extends OSCServer

# ## NOTE: cannot override parent
# @export var port := GodSCRokokoTrackerPlugin.OSC_PORT_DEFAULT

func _init() -> void:
	print("_init %s  port: %s" % [self, port])
	port = GodSCRokokoTrackerPlugin.OSC_PORT_DEFAULT
	print("port: %s" % port)

func _enter_tree() -> void:
	print("_enter_tree %s  port: %s" % [self, port])

# ## Override
func _ready() -> void:
	# print("_ready %s" % self)
	print("%s NOT LISTENING BY DEFAULT -- port: %s" % [self, port])
	print("self.port %s" % self.port)
	# server.listen(port)


# ## dummy for now
func stop() -> void:
	pass
