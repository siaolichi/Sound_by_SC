
//--------------------------GUI---------------------------------
(
~slider      = Array.fill(9,{1});			//Slider GUI  （ 0到1）-> ~slider[i].value
~sliderStatic = Array.fill(9,{""});
~pad      = Array.fill(8,{1!8});			//Slider GUI  （ 0到1）-> ~slider[i].value
~channel = 1;
~channelBt1 = 1;
~channelBt2 = 0;
w = Window.new('APCmini',Rect(850, 500, 500,400)).front.background_(Color.new255(255,255,255));
w.alwaysOnTop_(true);
8.do({|i|
	~slider[i] = Slider(w, Rect(30+(50*i),280,40,80));
});
~masterVolume=Slider(w, Rect(30+(50*8),280,40,80));
64.do({|i|
	if(i<8,{
		~pad[(i/8).asInteger][i%8] = Button(w,Rect(30+(50*(i%8)),10+(30*(i/8).asInteger),40,20))
		.states_([[i%8,Color.new255(255,255,255),Color.new255(90,90,90)],[i%8,bgColor:Color.white]]).action_({});
	},{
		if(i%8 == 0,{
			~pad[(i/8).asInteger][i%8] = Button(w,Rect(30+(50*(i%8)),10+(30*(i/8).asInteger),40,20))
			.states_([[(i/8),Color.new255(255,255,255),Color.new255(90,90,90)],[(i/8),bgColor:Color.white]]).action_({});
		},{
			~pad[(i/8).asInteger][i%8] = Button(w,Rect(30+(50*(i%8)),10+(30*(i/8).asInteger),40,20))
			.states_([["",Color.new255(255,255,255),Color.new255(90,90,90)],["",bgColor:Color.white]]).action_({})});
	});
});
~channelBt1 = Button(w,Rect(40, 250,20,20))
.states_([["",Color.new255(255,255,255),Color.new255(90,90,90)],["",bgColor:Color.red]]).action_({});
~channelBt2 = Button(w,Rect(90, 250,20,20))
.states_([["",Color.new255(255,255,255),Color.new255(90,90,90)],["",bgColor:Color.red]]);
~stopAll = Button(w,Rect(440, 220,20,20))
.states_([["",Color.new255(255,255,255),Color.new255(90,90,90)],["",bgColor:Color.red]]);
);
(
MIDIClient.init;
MIDIIn.connectAll;
~padVal      = Array.fill(100,{-1});			//8x8 Pad 	  （-1跟1）
~sliderVal   = Array.fill(9,{0});			//Slider      （ 0到1）
~newSliderVal= Array.fill(9,{0});
~ctrlBt      = Array.fill(4,{1});
~navBt		 = Array.fill(4,{1});
~lauchBt	 = Array.fill(7,{1});
~shift;
//x = NdefMixer(s);
//----------------------CONTROLLER-----------------------------
(
MIDIdef.noteOn(\noteOnTest, {
	arg vel, nn, chan, src;
	~padVal[nn]=~padVal[nn]*(-1);
	//[nn, ~padVal[nn]].postln;

	//切換Channel：--------------------------------------------
	{
		if(nn==64,{~channel = 1;});
		if(nn==65,{~channel = 2;});
		if(~channel==1,
			{~channelBt1.value_(1);~channelBt2.value_(0);},
			{~channelBt1.value_(0);~channelBt2.value_(1);});
		if(nn==89,{~stopAll.value_(1)},~stopAll.value_(0));
		//pad後的內容寫這：-----------------------------------------
		8.do({|i|
			if(nn == (i+56),{if(~padVal[nn]==(-1),{~pad[0][i].value_(0);},{~pad[0][i].value_(1);})});
			if(nn == (i+48),{if(~padVal[nn]==(-1),{~pad[1][i].value_(0);},{~pad[1][i].value_(1);})});
			if(nn == (i+40),{if(~padVal[nn]==(-1),{~pad[2][i].value_(0);},{~pad[2][i].value_(1);})});
			if(nn == (i+32),{if(~padVal[nn]==(-1),{~pad[3][i].value_(0);},{~pad[3][i].value_(1);})});
			if(nn == (i+24),{if(~padVal[nn]==(-1),{~pad[4][i].value_(0);},{~pad[4][i].value_(1);})});
			if(nn == (i+16),{if(~padVal[nn]==(-1),{~pad[5][i].value_(0);},{~pad[5][i].value_(1);})});
			if(nn == (i+8  ),{if(~padVal[nn]==(-1),{~pad[6][i].value_(0);},{~pad[6][i].value_(1);})});
			if(nn == (i       ),{if(~padVal[nn]==(-1),{~pad[7][i].value_(0);},{~pad[7][i].value_(1);})});
		});
		if(nn<64,{
			["Pad"+(7-((nn/8).asInteger))+(nn%8), ~pad[(7-(nn/8).asInteger)][(nn%8)].value].postln;
			~pad[(7-((nn/8).asInteger))][(nn%8)].doAction;
		});
	}.defer;
}).permanent_(true);
);
(
MIDIdef.cc(\slider,{
	arg vel, nn, chan, src;
	//[vel, nn, chan, src].postln;
	{
		8.do({|i|
			if((i+48) == nn,{
				["Slider"+(i+1),vel ].postln;
				~slider[i].valueAction_(vel.linlin(1,127,0.00,1.00));
			});
		});
		if(nn == 56,{
			["masterVolume",vel].postln;
			~masterVolume.valueAction_(vel.linlin(1,127,0.00,1.00));
			s.volume=vel.linlin(1,127,0.0-90,0.00);
		});
		if(~channel == 1, {
		});
		if(~channel == 2, {
		});
	}.defer;
}).permanent_(true);
);
);
);
//////////////////////////////////////////////////////






//SkipJack.stopAll;
//w.bounds;
//w.close;