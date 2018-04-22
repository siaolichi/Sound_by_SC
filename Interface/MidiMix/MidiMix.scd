/*-------------------------------------------------

這裡開始先全跑一次

-------------------------------------------------*/
MIDIClient.init;
MIDIIn.connectAll;

v = s.volume;

~masterVolume = 0;
~mute = [1,4,7,10,13,16,19,22,0];
~recArm = [3,6,9,12,15,18,21,24];
~row = [62,25,26,27];
~sliderNum = [19,23,27,31,49,53,57,61,62];

~slider    = Array.fill(9,{1});
~sliderStatic = Array.fill(9,{""});

~muteVal = Array.fill(8,{-1});
~recArmVal = Array.fill(8,{-1});
~rowVal = Array.fill(8,{-1});
~knob      = Array.fill(8,{[0,0,0]});			//Knob GUI  （ 0到1）
~mutePad      = Array.fill(8,{0});			//Pad GUI  （ 0到1）
~recArmPad      = Array.fill(8,{0});			//Pad GUI  （ 0到1）
~rowPad      = Array.fill(4,{0});			    //Pad GUI  （ 0到1）
~muteVal = Array.fill(8,{-1});
~recArmVal = Array.fill(8,{-1});
~rowVal = Array.fill(8,{-1});
(
w = Window.new('MidiMix',Rect(900, 500, 450,350)).front.background_(Color.new255(255,255,255));
w.alwaysOnTop_(true);
8.do({|i|
	~slider[i] = Slider(w, Rect(25+(45*i),240,40,80));
	~mutePad[i] =Button(w, Rect(25+(45*i),180,40,20)).states_([[i+1,Color.new255(255,255,255),Color.new255(90,90,90)],["",bgColor:Color.white]]);
	~recArmPad[i] =Button(w, Rect(25+(45*i),210,40,20)).states_([["",Color.new255(255,255,255),Color.new255(90,90,90)],["",bgColor:Color.white]]);
});
24.do({|i|
	~knob[(i/3).asInteger][(i%3)] = Knob.new(w, Rect(25+(45*(i/3).asInteger),30+(50*(i%3)), 40, 40));
});
4.do({|i|
	~rowPad[i] = Button(w, Rect(385, 45+(i*45),40,20)).states_([["",Color.new255(255,255,255),Color.new255(90,90,90)],["",bgColor:Color.white]]);
});
~masterVolume=Slider(w, Rect(25+(45*8),240,40,80));
);





(
MIDIdef.noteOn(\noteOnTest, {
	arg vel, nn, chan, src;
	//[vel, nn, chan, src].postln;
	//[vel,nn].postln;
	{
		8.do({|i|
			if((~mute[i] == nn),{
				~muteVal[i] = ~muteVal[i]*(-1);
				if(~muteVal[i]==(-1),{
					~mutePad[i].value_(0);},{
					~mutePad[i].value_(1);});
				~mutePad[i].doAction;
				["mute"+(i+1), ~muteVal[i]].postln;
			});
			if((~recArm[i] == nn),{
				~recArmVal[i] = ~recArmVal[i]*(-1);
				if(~recArmVal[i]==(-1),{
					~recArmPad[i].value_(0);},{
					~recArmPad[i].value_(1);});
				["recArm"+(i+1), ~recArmVal[i]].postln;
				~recArmPad[i].doAction;
			});
		});
		4.do({|i|
			if((~row[i] == nn),{
				~rowVal[i] = ~rowVal[i]*(-1);
				if(~rowVal[i]==(-1),{
					~rowPad[i].value_(0);},{
					~rowPad[i].value_(1);});
				["row"+(i+1), ~rowVal[i]].postln;
				~rowPad[i].doAction;
			});
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
			if(~sliderNum[i] == nn,{
				["Slider"+(i+1),vel ].postln;
				~slider[i].valueAction_(vel.linlin(1,128,0.00,1.00));
			});
		});
		3.do({|i|
			if(nn == (i+16),{
				["Knob"+1,i,vel].postln;
				~knob[0][i].valueAction_(vel.linlin(1,128,0.00,1.00));
			});
			if(nn == (i+20),{
				["Knob"+2,i,vel].postln;
				~knob[1][i].valueAction_(vel.linlin(1,128,0.00,1.00));
			});
			if(nn == (i+24),{
				["Knob"+3,i,vel].postln;
				~knob[2][i].valueAction_(vel.linlin(1,128,0.00,1.00));
			});
			if(nn == (i+28),{
				["Knob"+4,i,vel].postln;
				~knob[3][i].valueAction_(vel.linlin(1,128,0.00,1.00));
			});
			if(nn == (i+46),{
				["Knob"+5,i,vel].postln;
				~knob[4][i].valueAction_(vel.linlin(1,128,0.00,1.00));
			});
			if(nn == (i+50),{
				["Knob"+6,i,vel].postln;
				~knob[5][i].valueAction_(vel.linlin(1,128,0.00,1.00));
			});
			if(nn == (i+54),{
				["Knob"+7,i,vel].postln;
				~knob[6][i].valueAction_(vel.linlin(1,128,0.00,1.00));
			});
			if(nn == (i+58),{
				["Knob"+8,i,vel].postln;
				~knob[7][i].valueAction_(vel.linlin(1,128,0.00,1.00));
			});
		});
		if(nn == 62,{
			//控制音量
			["masterVolume",vel].postln;
			~masterVolume.valueAction_(vel.linlin(1,128,0.00,1.00));
			s.volume=vel.linlin(1,127,-90,0)
		});
	}.defer
});
)




/*-------------------------------------------------

跑到這裡結束

-------------------------------------------------*/


/*-------------------------------------------------

使用範例：

KNOB（利用Pdefn改數值）:
~knob[0][0].action_({|butt|
	Pdefn(\drum3_amp, butt.value);
});

SLIDER（利用Pdefn改數值）:
~slider[0].action_({|butt, mod|
    Pdefn(\sound_amp,butt.value);
};

MUTE PAD:
~mutePad[0].action_({|butt, mod|
	if(butt.value==1,{
		//按鈕按下
	},{
		//按鈕取消
	});
};);

RecArmPAD:
~recArmPad[0].action_({|butt, mod|
	if(butt.value==1,{
		//按鈕按下
	},{
		//按鈕取消
	});
};);
-------------------------------------------------*/


