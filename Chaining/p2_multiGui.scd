//////////////////////////////////////
// GUI Window:
//////////////////////////////////////
(
q=q?();
q.butWidth = 80;
q.ctlBoard = Window("control board", Rect(0, 36, q.butWidth * 1.10 * 8, 400)).front;
q.ctlBoard.addFlowLayout;

q.playButs = 8.collect { |px|
	var name = px;
	var btname = "play" ++ name;
	Button(q.ctlBoard, Rect(0, 0, q.butWidth, 80))
	.states_([[btname, Color.black, Color.grey], [btname, Color.black, Color.green]])
	.action_{|butt| [
		{"stop Ndef(%)\n".post;
			~check.put(px, false);
			~input2.put(px, 1);
		},
		{"play Ndef(%)\n".post;
			~check.put(px, true);
			~input2.put(px, 1);
		},
	][butt.value].value;
	};
};

q.controlButs = 8.collect { |px|
	var name = px;
	var funcName = ("set" ++ (px+1)).asSymbol.postcln;
	var btname = "ctl" + name;
	Button(q.ctlBoard, Rect(0, 0, q.butWidth, 80))
	.states_([[btname, Color.black, Color.grey], [btname, Color.black, Color.green]])
	.action_{|butt| [
		{
			"control Ndef(%) OFF\n".postln;
			~check.put(px+8, false);
			~input2.put(px+8, 1);
		},
		{
			"control Ndef(%) ON\n".postln;
			~check.put([px+8], true);
			~input2.put([px+8], 1);
		}
	][butt.value].value;
	};
};


//q.sensorValuesNormd = q.sensorValuesNormd ? 0.5 ! 16;
q.arduSliders = 16.collect({ Slider(q.ctlBoard, Rect(0,0, 38, 110)) });
// keep updating the play button's state
SkipJack({
	8.do({|i|
	q.playButs[i].value = ~check[i];
	q.controlButs[i].value = ~check[i+8];
	});
	16.do({ |i|
		q.arduSliders[i].value = ~input1[i]/800;
	});

},
	0.1, { q.ctlBoard.isClosed }, name: "playstate"
);

//~skipJackConteoll.stop;
);
