// 月 14  7 2025 16:45
// Send Rokoko props as additional message.

// Properties are an additional protocol that is sent in a separate OSC message.
// The message format is:

// ['/rokoko/props/', r, g, b, type, posx, posy, posz, qx, qy, qz, qw]

// For the meanings of the above refer to this json format definition from the Rokoko website:

// {
// name: "Box1",
// color: {r, g, b} // bytes
// type: 0/1/2 // 0: box, 1: stick, 2: camera
// position: {x: 0, y: 0, z: 0}, // Y-up, Z-forward
// rotation: {x: 0, y: 0, z: 0, w: 1}, // quaternion
// }


Props {
	var avatar, <r = 0, <g = 0, <b = 0;
	var <type = 0;
	var <x = 0, <y = 0, <z = 0;
	var <qx = 0, <qy = 0, <qz = 0, <qw = 0;

	*new { | avatar | ^this.newCopyArgs(avatar) }

	setColor { | argr, argg, argb |
		r = argr; g = argg; b = argb;
		this.send;
	}

	setType { | argType |
		type = argType;
		this.send;
	}

	setPos { | argx, argy, argz |
		#x, y, z = [argx, argy, argz];
		this.send;
	}

	setRot { | argqx, argqy, argqz, argqw |
		#qx, qy, qz, qw = [argqx, argqy, argqz, argqw];
		this.send;
	}

	setPosRot { | argx, argy, argz, argqx, argqy, argqz, argqw |
		#x, y, z = [argx, argy, argz];
		#qx, qy, qz, qw = [argqx, argqy, argqz, argqw];
		this.send;
	}

	r_ { | argx | r = argx; this.send }
	g_ { | argx | g = argx; this.send }
	b_ { | argx | b = argx; this.send }
	x_ { | argx | x = argx; this.send }
	y_ { | argx | y = argx; this.send }
	z_ { | argx | z = argx; this.send }
	qx_ { | argx | qx = argx; this.send }
	qy_ { | argx | qy = argx; this.send }
	qz_ { | argx | qz = argx; this.send }
	qw_ { | argx | qw = argx; this.send }

	send {
		avatar.changed(\props, [
			avatar.name, r, g, b, type,
			x, y, z, qx, qy, qz
		])
	}

}