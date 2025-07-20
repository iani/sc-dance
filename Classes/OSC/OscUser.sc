// 日 20  7 2025 15:52
// Enable forwarding and evaluation of code.
OscUser : NamedInstance {
	*localUser { ^this.default }
	init {
		if (name === \default) {
			name = Platform.userHomeDir.fileName.asSymbol;
		};
	}

	makeWindow {
		Windows.makeWindow(this, \mainWindow, { | w |
			var codeView;
			w.name_("Code:").alwaysOnTop_(true);
			w.bounds_(
				Window.bottomRight(870, 250).top_(250));
			w.view.layout = VLayout(
				codeView = TextView()
			);
			codeView.font = Font(nil, 24);
			codeView.addAdapter(this, \code, { | a, code |
				a.listener.string = code;
			});
			codeView.onClose = { codeView.removeAdapter(this, \code) };
			w.front;
		});
		this.enable;
	}
	enable {
		thisProcess.interpreter.preProcessor = { | code |
			this.changed(\code, code, name);
			code;
		};
	}
	disable {
		thisProcess.interpreter.preProcessor = nil;
	}

	// debugging
	postCode { this.simpleTrace; }
	unpostCode { this.simpleUntrace }

}