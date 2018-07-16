//Part1 3mins

Pdef(\hi_hill,{Pbind(
	\instrument, 		\pattern_4,
	\dur, 					Pdefn(\beat)*0.0625,
	\leng,              		Pkey(\dur)/4,
	\amp,              		Pseq([0,1],inf),
	\freq,              		Pseq([[60,100]],inf);
)}).play;
Pdef(\withIntro1,{Pbind(
	\instrument, 		\pattern_3,
	\dur, 					Pdefn(\beat)*8,
	\leng,              		Pkey(\dur),
	\midi,   				Pxrand([36,40,43,45],inf),
	\amp,               	0.3
)}).play;
Pdef(\bspulse,{Pbind(
	\instrument,   		\bssine,
	\dur, 					Pdefn(\beat)*Pseq([3,1],inf),
	\leng,           		Pkey(\dur),
	\amp,               	Pseq([0,0.1],inf),
	\freq,              		300,
	\width,            		0.02,
	\decay,            		2
)}).play;
Pdef(\high_speed_drum,{Pbind(
	\instrument,			\drum,
	\dur,             		Pseq([28, 0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25, 0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25]*0.125,inf),
	\amp_release, 		0.4,
	\amp,              		0.5
)}).play;
Pdef(\highBlip,{Pbind(
	\instrument,		 	\highBlip,
	\freq,              		[880,1200,660],
	\amp,               	Pseq([0.4],inf),
	\dur,               		Pdefn(\beat)*Pseq([0.25,0.75],inf)
)}).play;
Pdef(\bssine4,{Pbind(
	\instrument,      	\bssine,
	\dur, 					Pdefn(\beat)/4,
	\leng,              		Pkey(\dur),
	\amp,              		1,
	\freq,              		Pseq([120,120,100,120,50,120,50,120,50,120,50,120,60,120,50,120],inf).midicps,
	\width,            		0.3,
	\decay,           		0.1
)}).play;
Pdef(\blingbling,{Pbind(
	\instrument,       	\blingbling,
	\amp,              		Pseq([2],inf),
	\dur,               		Pdefn(\beat)*0.25,//Pseq([0.125,0.125,0.125,0.125,0.5],inf)*2*Pdefn(\beat),
)}).play;
Pdef(\drum,{Pbind(
	\instrument,       	\drum,
	\dur,                   	Pdefn(\beat),//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,                  	Pseq([0.2,0.1,0.15,0.1],inf)*6,
	\amp_release,     	Pkey(\dur)*0.5,
	\mix,                  	0.1,
	\amp2,               	Pdefn(\drum_amp2),
	\freq2,               	Pdefn(\drum_freq2)
)}).play;
Pdefn(\drum_basic_beat, 4);
Pdef(\drum_basic,{Pbind(
	\instrument,       	\drum_basic,
	\dur,              		Pdefn(\beat)*Pdefn(\drum_basic_beat),//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,             	 	0.5
)}).play;
Pdef(\middle_pad,{Pbind(
	\instrument,       	\low_pad,
	\amp,                  	1,
	\legato,               	2,
	\freq,                   	Pseq(([62,64,69,72,69,67]-12).midicps,inf),
	\dur,                    	2*Pdefn(\beat),
)}).play;