// 土  2  8 2025 13:48
// asCompileString produces human readable and editable text.
// For simple objects such as Arrays or Dictionaries of Strings and Numbers, thisdoc
// is prefererable to the text produced by asTextArchive

+ Object {
	writeSimpleArchive { arg pathname;
		var text = this.asCompileStrig;
		var file = File(pathname, "w");
		if(file.isOpen) {
			protect {
				file.write(text);
			} { file.close };
		} {
			MethodError("Could not open file % for writing".format(pathname.asCompileString), this).throw;
		}
	}

}