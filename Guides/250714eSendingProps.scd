// 月 14  7 2025 18:18
// props is a special OSC message that sends
// additional properties of the avatar such as position, color etc.
// See file Overview.org in Guides for details.

//1. Setup an Avatar with default name to send to local address
Avatar(\proptest).makeDefault.sendToSelf;
//2. Post messages received at local address, for checking.
TraceOsc.enable;
//3. Send some \prop messages
//Note: When sending to local sc addres, OSC
//message address is changed from /prop to /p to prevent feedback.
//Messages send to any other address are sent as /prop.
//Send props as they are, without changing:
Avatar.props.send;
//Set color
Avatar.setColor(10, 100, 5);
//Set type (Note: Color stays unchanged)
Avatar.setType(2);
//Set position
Avatar.setPos(0.1, 10.3, 0.1);
//Set rotation
Avatar.setRot(-0.1, -0.3, 0.1, -0.5);
//Set position and rotation
Avatar.setPosRot(0.31, 1.3, 2.1, -0.31, -0.33, 0.31);
//Set individual values
//These methods are less used. Therefore only implemented in Props
Avatar.props.r = 200;
Avatar.props.g = 17;
Avatar.props.b = 7;
Avatar.props.x = -2;
Avatar.props.y = 0.5;
Avatar.props.z = -7;
Avatar.props.qx = 2pi;
Avatar.props.qy = pi;
Avatar.props.qz = -pi;
Avatar.props.qw = 0.1;
//Stop posting osc
TraceOsc.disable;
