
+ Window {
	*topLeft { | w = 400, h = 200 |
		^Rect(0, Window.screenBounds.height - h, w, h);
	}

	*topRight { | w = 400, h = 200 |
		^Rect(Window.screenBounds.width - w, Window.screenBounds.height - h, w, h);
	}

	*bottomRight { | w = 400, h = 200 |
		^Rect(Window.screenBounds.width - w, 0, w, h);
	}
}