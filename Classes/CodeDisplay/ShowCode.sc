// 火 15  7 2025 10:08
// Show evaluated code in a window.

ShowCode : NamedInstance {

	makeWindow {
		Windows.makeWindow(this, \mainWindow, { | w |
			var codeView;
			w.name_("Code:").alwaysOnTop_(true);
			w.bounds_(Window.bottomRight(1000, 250));
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
			this.changed(\code, code);
			code;
		};
	}
	disable {
		thisProcess.interpreter.preProcessor = nil;
	}
}