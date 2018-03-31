
~mutePad[0].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdefn(\drum3_amp, 0.5);
		Pdefn(\drum3_amp2, 0.5);
		Pdefn(\drum3_attack, 0.5);
		Pdef(\drum3).play;
	},{
		//按鈕取消
		Pdef(\drum3).stop;
	});
};);
~slider[0].action_({|butt, mod|
});
~slider[4].action_({|butt, mod|
	Pdefn(\bufNoise4_amp,butt.value);
});
~recArmPad[0].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\blingbling).play;
		Pdefn(\drum_basic_beat, 1);
		Pdef(\drum_basic).play;
	},{
		//按鈕取消
		Pdef(\blingbling).stop;
		//Pdefn(\drum_basic_beat, 8);
		Pdef(\drum_basic).stop;
	});
};);
~mutePad[1].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\drum1).play;
		Pdef(\alien).play;
	},{
		//按鈕取消
		Pdef(\drum1).stop;
		Pdef(\alien).stop;
	});
};);
~recArmPad[1].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdefn(\tzatzatza_dur,0.25);
		Pdef(\tzatzatza).play;
	},{
		//按鈕取消
		//Pdefn(\tzatzatza_dur,0.25);
		Pdef(\tzatzatza).stop;
	});
};);
~mutePad[2].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\blingbling).stop;
		Pdef(\drum1).stop;
		Pdef(\bufSaw2).play;
		Pdef(\bufLow2).play;
		Pdefn(\drum3_attack, 0.001);
		Pdef(\alien).stop;
	},{
		//按鈕取消
		Pdef(\bufLow2).stop;
		Pdef(\bufSaw2).stop;
		Pdef(\drum2).stop;
	});
};);
~recArmPad[2].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		//Pdef(\drum2).play;
		Pdef(\bufSin2).play;
	},{
		//按鈕取消
		Pdef(\bufSin2).stop;
	});
};);
~mutePad[3].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\drum2).stop;
		//Pdef(\drum3).stop;
		Pdef(\moon).play;
		Pdef(\low_pad).play;
	},{
		//按鈕取消
		Pdef(\moon).stop;
		Pdef(\low_pad).stop;
	});
};);
~recArmPad[3].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\drum).play;
		Pdefn(\drum_amp2,0);
		Pdefn(\drum_freq2,50);
	},{
		//按鈕取消
		Pdef(\drum).stop;
	});
};);
~mutePad[4].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\bufNoise4).play;
		Pdef(\part2).play;
		Pdef(\bomb).play;

//		Pdef(\drum).stop;
	},{
		//按鈕取消
		Pdef(\bufNoise4).stop;
		Pdef(\part2).stop;
		Pdef(\bomb).stop;
	});
};);
~recArmPad[4].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\alien2).play;
	},{
		//按鈕取消
		Pdef(\alien2).stop;
		Pdef(\bufSaw4).play;
		Pdef(\bufLow4).play;
		Pdef(\bufSin4).play;
	});
};);
~slider[5].action_({|butt, mod|
	Pdefn(\bufSaw4Sin4_amp,butt.value);
});
~mutePad[5].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\bufNoise4).stop;
		Pdef(\bomb).stop;
//		Pdef(\drum).stop;
	},{
		//按鈕取消
		Pdef(\part2).stop;
		Pdef(\bomb).stop;
	});
};);
~recArmPad[5].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\bass).play;
	},{
		//按鈕取消
		Pdef(\bass).stop;

	});
};);
~mutePad[6].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		//Pdef(\bufSaw4).stop;
		Pdef(\bufLow4).stop;
		//Pdef(\bufSin4).stop;
	},{
		//按鈕取消
		Pdef(\bufSaw4).stop;
		Pdef(\bufSin4).stop;
	});
};);
~mutePad[7].action_({|butt, mod|
	mod=butt.value;
	if(butt.value==1,{
		//按鈕按下
		Pdef(\bssinemelody).play;
	},{
		//按鈕取消
	});
};);

~knob[0][0].action_({|butt|
	Pdefn(\drum3_amp, butt.value);
});
~knob[0][1].action_({|butt|
	Pdefn(\drum3_amp2, butt.value);
});
~check02=0;
~knob[0][2].action_({|butt|
	if(butt.value.linlin(0,1,0,100).asInteger==1,{
		if(~check02==0,{
			~breeze=Synth(\breeze).run;
			~check02=1;
		});
	});
	if(butt.value.linlin(0,1,0,100).asInteger==0,{
		if(~check02==1,{
			~breeze.free;
			~check02=0;
		});
	});
	if(~check02==1,{
		~breeze.set(\freq2,butt.value.linlin(0,1,0.2,300));
		~breeze.set(\amp,butt.value.linlin(0,1,0,1));
	})
});
~check30=0;
~knob[3][0].action_({|butt|
	if(butt.value.linlin(0,1,0,100).asInteger==1,{
		if(~check30==0,{
			Pdefn(\bufNormal1_2_start, (Pseq((1..8)+45,inf)));
			Pdefn(\normal1_2_freq, 0.7);
			Pdefn(\normal1_2_dur, 0.5);
			Pdef(\bufNormal1_2).play;
			~check30=1;
		});
	});
	if(butt.value.linlin(0,1,0,100).asInteger==0,{
		if(~check30==1,{
			Pdef(\bufNormal1_2).stop;
			~check30=0;
		});
	});
	Pdefn(\bufNormal1_2_amp,butt.value*6);
});
~check31=0;
~knob[3][1].action_({|butt|
	if(butt.value.linlin(0,1,0,100).asInteger==1,{
		if(~check31==0,{
			Pdef(\highFreqNoise).play;
			~check31=1;
		});
	});
	if(butt.value.linlin(0,1,0,100).asInteger==0,{
		if(~check31==1,{
			Pdef(\highFreqNoise).stop;
			~check31=0;
		});
	});
	Pdefn(\highFreqNoise_amp,butt.value*2);
	Pdefn(\bufNormal1_2_start,46);
});
~check20=0;
~knob[2][0].action_({|butt|
	if(butt.value.linlin(0,1,0,100).asInteger==1,{
		if(~check20==0,{
			Pdef(\bufNoise2).play;
			~check20=1;
		});
	});
	if(butt.value.linlin(0,1,0,100).asInteger==0,{
		if(~check20==1,{
			Pdef(\bufNoise2).stop;
			~check20=0;
		});
	});
	Pdefn(\bufNoise2_amp,butt.value*0.8);
});
~knob[2][1].action_({|butt|
	Pdefn(\drum_amp2,butt.value);
	if(butt.value==1,{
		Pdef(\moon).stop;
		Pdef(\low_pad).stop;
	});
});

~knob[2][2].action_({|butt|
	Pdefn(\drum_freq2,butt.value.linlin(0,1,50,150));
});
/*
//
Pdefn(\drum3_attack, 1);
Pdef(\drum3).play;
//
Pdef(\blingbling).play;
Pdef(\drum_basic).play;
//
Pdef(\drum1).play;
//Pdef(\bufNormal1).play;
Pdef(\alien).play;
//
Pdef(\tzatzatza).play;
//
Pdefn(\tzatzatza_dur,0.25);
//
Pdef(\blingbling).stop;
Pdef(\drum1).stop;
//
Pdefn(\drum3_attack, 0.001);
Pdef(\alien).stop;
Pdef(\drum2).play;
Pdef(\bufSin2).play;
Pdef(\bufLow2).play;
Pdef(\bufNoise2).play;
Pdef(\bufSaw2).play;
Pdef(\bufNormal1).stop;
//
Pdef(\drum2).stop;
Pdef(\drum3).stop;
Pdef(\moon).play;
Pdef(\low_pad).play;
//
Pdef(\tzatzatza).stop;
//
Pdef(\drum_basic).stop;
Pdef(\bufSin2).stop;
Pdef(\bufNoise2).stop;
Pdef(\bssinemelody).play;
//

Pdef(\drum).play;
Pdef(\bssinemelody).stop;
Pdef(\drum_basic).play;
Pdefn(\normal1_2_freq, 0.7);
Pdefn(\normal1_2_dur, 0.5);
Pdefn(\bufNormal1_2_start, (Pseq((1..8)+45,inf)));
Pdef(\bufNormal1_2).play;
//
Pdef(\bufLow2).stop;
Pdef(\bufSaw2).stop;
//
Pdef(\alien2).play;
Pdef(\bufNormal1).stop;
//
*/
~rowPad[3].action_({|butt, mod|

	Pdef(\highFreqNoise).stop;
	Pdef(\bomb).stop;
	Pdef(\alien2).stop;
	Pdef(\drum_basic).stop;
	Pdef(\bufNormal1).stop;
	Pdef(\bufNormal1_2).stop;
	Pdef(\bufSin2).stop;
	Pdef(\bufLow2).stop;
	Pdef(\bufNoise2).stop;
	Pdef(\bufSaw2).stop;
	Pdef(\low_pad).stop;
	Pdef(\moon).stop;
	Pdef(\bssinemelody).stop;
	Pdef(\withIntro2).stop;
	Pdef(\tzatzatza).stop;
	Pdef(\alien).stop;
	Pdef(\blingbling).stop;
	Pdef(\bssine4).stop;
	Pdef(\bssine3).stop;
	Pdef(\drum3).stop;
	Pdef(\drum2).stop;
	Pdef(\drum1).stop;
	Pdef(\drum).stop;
	Pdef(\part2).stop;
	Pdef(\bufNoise4).stop;
	Pdef(\bufSaw4).stop;
	Pdef(\bufLow4).stop;
	Pdef(\bufSin4).stop;
	Pdef(\bass).stop;

};);