f = Avatar.animator.makeFilter(\hipx, { | in, ctl | ctl });
f.joint;
f.index;
f.controls;
f.filter(100);
f.controls[0] = pi;
f.filter(100);
//:Testing getFilter, addFilter
Avatar.getFilter(\hipy);
//: Testing message to arry conversion
Avatar.sessionData.parser.symbols;
Avatar.messages.first;

Avatar.default.load;
Avatar.default;
Avatar.default.parser.message;
Avatar.default.parser parse: Avatar.default.parser.message;
Avatar.default.parser parse: ([\xavier, \serra] ++ Avatar.default.parser.message);

Avatar.default.parser.msgIndex(\hip);
Avatar.default.parser.getJointValue(\hip);
Avatar.default.parser.getJointValue(\hipx);
Avatar.default.parser.getJointValue(\chesty);
Avatar.default.parser.postMsgDict;
Avatar.default.parser.postCtlDict;

Avatar.default.parser.parse(Avatar.default.parser.message);


[\x, \y] != [\x, \y]
[\x, \y] != [\x, \z]


//: Earlier, preliminary data tests
p = Avatar.parser;
p.ctlNames;
p.ctlNames;
p.ctlNames == p.msgNames;
p.msgDict[\hip];
p.ctlDict[\hip];
p.msgDict[\hipx];
p.ctlDict[\hipx];
p.msgIndex(\hip);
p.ctlIndex(\hip);
p.msgIndex(\hipx);
p.ctlIndex(\hipx);

//:
p.busNames do: { | n, i |
	postf("busName: %, msgName: %, busName === msgName: %\n",
		n, p.msgNames[i], n === p.msgNames[i]
	)
};
//:

//: