//Part1
Pdef(\hi_hill,{Pbind(
	\instrument, 		\pattern_4,
	\dur, 					Pdefn(\beat)*0.125,
	\leng,              		Pkey(\dur)/4,
	\amp,              		Pseq([0,1],inf),
	\freq,              		Pseq([[60,100]],inf);
)}).play;
Pdef(\bspulse,{Pbind(
	\instrument,   		\bssine,
	\dur, 					Pdefn(\beat)*Pseq([6,2],inf),
	\leng,           		Pkey(\dur),
	\amp,               	Pseq([0,0.1],inf),
	\freq,              		300,
	\width,            		0.02,
	\decay,            		2
)}).play;
Pdef(\highBlip,{Pbind(
	\instrument,		 	\highBlip,
	\freq,              		[880,1200,660],
	\amp,               	Pseq([0.4],inf),
	\dur,               		Pdefn(\beat)*Pseq([0.5,1.5],inf)
)}).play;

//Part2
Pdef(\high_speed_drum,{Pbind(
	\instrument,			\drum,
	\dur,             		Pdefn(\beat)*Pseq([28,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25]*0.5,inf),
	\amp_release, 		0.4,
	\amp,              		0.5
)}).play;
Pdef(\bssine4,{Pbind(
	\instrument,      	\bssine,
	\dur, 					Pdefn(\beat)/2,
	\leng,              		Pkey(\dur),
	\amp,              		1,
	\freq,              		Pseq([120,120,100,120,50,120,50,120,50,120,50,120,60,120,50,120],inf).midicps,
	\width,            		0.3,
	\decay,           		0.1
)}).play;
Pdef(\withIntro1,{Pbind(
	\instrument, 		\pattern_3,
	\dur, 					Pdefn(\beat)*4,
	\leng,              		Pkey(\dur),
	\midi,   				Pxrand([36,40,43,45],inf),
	\amp,               	0.3
)}).play;

//Part3
Pdef(\hi_hill).stop;
Pdef(\bspulse).stop;
Pdef(\highBlip).stop;
Pdef(\blingbling,{Pbind(
	\instrument,       	\blingbling,
	\amp,              		Pseq([1],inf),
	\dur,               		Pdefn(\beat)*0.5,//Pseq([0.125,0.125,0.125,0.125,0.5],inf)*2*Pdefn(\beat),
)}).play;
Pdef(\drum,{Pbind(
	\instrument,       	\drum,
	\dur,                   	Pdefn(\beat)*2,//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,                  	Pseq([0.2,0.1,0.15,0.1],inf)*6,
	\amp_release,     	Pkey(\dur)*0.5,
	\mix,                  	0.1,
	\amp2,               	Pdefn(\drum_amp2),
	\freq2,               	Pdefn(\drum_freq2)
)}).play;
Pdef(\drum2,{Pbind(
	\instrument,       \drum2,
	\dur,              Pdefn(\beat)/4,//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,             Pseq([0.5,0.2,0.2,0.2],inf)*2
)}).play;

//Part4
Pdef(\high_speed_drum).stop;
Pdef(\middle_pad,{Pbind(
	\instrument,       	\low_pad,
	\amp,                  	1,
	\legato,               	2,
	\freq,                   	Pseq(([62,64,69,72,69,67]-12).midicps,inf),
	\dur,                    	4*Pdefn(\beat),
)}).play;
Pdef(\drum4,{Pbind(
	\instrument,       \drum4,
	\dur,              Pdefn(\beat),//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,              Pseq([0.2,0.2,0.4,0.2,0.2,0.3,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2],inf)*2,
	\freq,               100*Pkey(\amp)+50,
	\decay,            0.2*Pkey(\amp),
	\fdecay,           0.1,
	\attack,            0.2,
)}).play;
Pdef(\bass,{Pbind(
	\instrument,  		\bass,
	\freq,              		50,
	\amp,               	0.6,
	\dur,               		Pdefn(\beat)*8,
)}).play;

//Part5
Pdef(\bssine4).stop;
Pdef(\withIntro1).stop;
Pdef(\alien,{Pbind(
	\instrument,        \alien,
	\amp,              1.2,
	\dur,               Pdefn(\beat)*32,
	\attack,            1,
	\decay,            Pkey(\dur)*1.5,
)}).play;
Pdef(\alien2,{Pbind(
	\instrument,        \alien2,
	\amp,              0.7,
	\dur,               Pdefn(\beat)*32,
	\attack,            4,
	\decay,            Pkey(\dur)*1.5,
)}).play;

//Part6
Pdef(\blingbling).stop;
Pdef(\drum).stop;
Pdef(\tzatzatza,{Pbind(
	\instrument,       \tzatzatza,
	\dur,                Pdefn(\beat)*0.125,
	//Pseq([0.125,0.125,0.125,0.125,0.25,0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.25],inf)*
	\amp,              Pseq((0..7).addAll((7..0)),inf)/40,
	\freq,              240,
	\mul4sound,    Pseq([1,8,9,5],inf)/10,
	\mul4LFPar,     Pseq([1,5,10,2],inf)*0.1
)}).play;
Pdef(\kakaka,{Pbind(
	\instrument,       \kakaka,
	\dur,               Pdefn(\beat)/4,
	\amp,              Pseq([0.4,0.1,0.1,0.1],inf),
	\freq,              Pseq((62!28).addAll(64!28).addAll(69!28).addAll(72!28).addAll(67!28),inf)
)}).play;

//Part7
Pdef(\middle_pad).stop;
Pdef(\drum4).stop;


//Part8
Pdef(\kakaka).stop;
Pdef(\tzatzatza).stop;


//Part9
Pdef(\drum1).stop;
Pdef(\bass).stop;

//Part10
Pdef(\drum2).stop;
Pdef(\alien).stop;

//Part11
Pdef(\alien2).stop;