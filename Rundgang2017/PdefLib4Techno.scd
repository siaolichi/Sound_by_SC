Pdefn(\beat, 60/120);
Pdef(\drum,{Pbind(
	\instrument,       \drum,
	\dur,                   Pdefn(\beat)/4,//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,                  Pseq([0.2,0.1,0.15,0.1],inf)*6,
	\amp_release,     Pkey(\dur)*0.5,
	\mix,                  Pseq((0..15)/16*0.3,inf)+0.3,
	\amp2,               Pdefn(\drum_amp2),
	\freq2,               Pdefn(\drum_freq2)
)}).play;
Pdefn(\drum_basic_beat, 2);
Pdef(\drum_basic,{Pbind(
	\instrument,       \drum_basic,
	\dur,              Pdefn(\beat)*Pdefn(\drum_basic_beat),//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,              0.5
)}).play;
Pdef(\drum1,{Pbind(
	\instrument,       \drum1,
	\dur,              (Pdefn(\beat))*Pseq([0.5,0.5,0.5,0.5,0.5],inf),
	\amp,             0.2,
	\roomsize, 500,
	\revtime, 103,
	\damping, 0.43,
	\inputbw, 0.51,
	\drylevel, -5,
	\earlylevel, -26,
	\taillevel, -20
)}).play;
Pdef(\drum2,{Pbind(
	\instrument,       \drum2,
	\dur,              Pdefn(\beat)/4,//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,             Pseq([0.5,0.2,0.2,0.2],inf)*2
)}).play;
Pdefn(\drum3_amp, 0.5);
Pdefn(\drum3_amp2, 0.5);
Pdefn(\drum3_attack, 4);
Pdef(\drum3,{Pbind(
	\instrument,      \drum3,
	\dur,                Pdefn(\beat),//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,              Pdefn(\drum3_amp),//Pseq([0.5,0.2,0.2,0.2],inf),
	\amp2,             Pdefn(\drum3_amp2),
	\freq,               100,
	\decay,            1,
	\fdecay,           2,
	\attack,            Pdefn(\drum3_attack)
)}).play;
Pdef(\drum4,{Pbind(
	\instrument,       \drum4,
	\dur,              Pdefn(\beat)/2,//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,              Pseq([0.8,0.2,0.2,0.2],inf),
	\freq,               100,
	\decay,            1,
	\fdecay,           0.1,
	\attack,            0.1,
)}).play;
Pdef(\bssine3,{Pbind(
	\instrument,        \bssine,
	\dur, 			       Pdefn(\beat)/4,
	\leng,                 Pkey(\dur),
	\amp,                  Pexprand(0.5,1,inf),
	\width,                Pexprand(0,0.5,inf),
	\freq,                  Pseq(([62,64,69,72,69]+48).midicps, inf)
)}).play;
Pdef(\bssine4,{Pbind(
	\instrument,        \bssine,
	\dur, 				Pdefn(\beat)/4,
	\leng,              Pkey(\dur),
	\amp,              1,
	\freq,              Pseq([120,120,100,120,50,120,50,120,50,120,50,120,60,120,50,120],inf).midicps,
	\width,            0.3,
	\decay,            0.1
)}).play;
Pdef(\blingbling,{Pbind(
	\instrument,        \blingbling,
	\amp,              Pseq([2],inf),
	\dur,               Pdefn(\beat)*0.25,//Pseq([0.125,0.125,0.125,0.125,0.5],inf)*2*Pdefn(\beat),
)}).play;
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
	\attack,            1,
	\decay,            Pkey(\dur)*1.5,
)}).play;
Pdefn(\tzatzatza_dur,0.25);
Pdef(\tzatzatza,{Pbind(
	\instrument,       \tzatzatza,
	\dur,                Pdefn(\beat)*Pdefn(\tzatzatza_dur),
	//Pseq([0.125,0.125,0.125,0.125,0.25,0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.125,0.25],inf)*
	\amp,              Pseq((0..7).addAll((7..0)),inf)/40,
	\freq,              100,
	\mul4sound,    Pseq([1,8,9,5],inf)/10,
	\mul4LFPar,     Pseq([1,5,10,2],inf)*0.1
)}).play;
Pdef(\kakaka,{Pbind(
	\instrument,       \kakaka,
	\dur,               Pdefn(\beat)/4,
	\amp,              Pseq([0.4,0.4,0.4,0.1],inf),
	\freq,              Pseq((62!28).addAll(64!28).addAll(69!28).addAll(72!28).addAll(67!28),inf)
)});
Pdef(\withIntro2,{Pbind(
	\instrument,        \pattern_3,
	\dur, 				Prand([8,16],inf)*Pdefn(\beat),
	\leng,              Pkey(\dur),
	\midi,   			Pseq(([62,64,69,72,69,67]),inf),
	\amp,               0.5
)}).play;
Pdef(\bssinemelody,{Pbind(
	\instrument,        \bssine,
	\dur, 				Pseq([2,4,8],inf)*Pdefn(\beat),
	\leng,              Pkey(\dur)*1.2,
	\amp,               0.5,
	\freq,              Pseq([62,64,69,72,69,67,62,72,69,64,69,60]).midicps,
	\width,            0.02,
	\decay,            2
)}).play;
Pdef(\moon, Pbind(
	\instrument, \moon,
	\amp,            0.1,
	\freq,             Pseq([62,64,69,72,69,67],inf),
	\root,             -2,
	\legato,          1,
	\cutoff,           4500,
	\dur,              Pseq([8,8,8,2,6],inf)*Pdefn(\beat),
)).play;
Pdef(\low_pad,{Pbind(
	\instrument,        \low_pad,
	\amp,                  1,
	\legato,               1,
	\freq,                   Pseq(([62,64,69,72,69,67]-24).midicps,inf),
	\dur,                    16*Pdefn(\beat),
)}).play;
Pdef(\bufSin2,{Pbind(
	\instrument,        \bufSin,
	\buf,                  Pdefn(\bufnum2),
	\dur,                   Pdefn(\beat)*32,
	\start,                 40*44100,
	\end,                  (5000+Pkey(\start)),
	\freq,                  10,
	\amp,                 Pseq([0,0.5],inf),
	\release,             Pkey(\dur)/2,
	\attack,              Pkey(\dur)
)}).play;
Pdef(\bufLow2,{Pbind(
	\instrument,        \bufLow,
	\amp,                 Pseq([1],inf),
	\buf,                  Pdefn(\bufnum2),
	\start,                 (Prand([[40,20]],inf)*44100),
	\end,                  Pkey(\dur)*2*44100+Pkey(\start),
	\freq,                  [0.2,0.25],
	\dur,                   Pdefn(\beat)/4,
	\attack,              1e-5,
	\release,             Pkey(\dur)/2,
)}).play;
Pdef(\bufNoise2,{Pbind(
	\instrument,        \bufNoise,
	\amp,                 Pdefn(\bufNoise2_amp, 0.4),
	\buf,                  Pdefn(\bufnum2),
	\dur,                   Pdefn(\beat)*32,
	\ptrrate,              Pseq([[1,0.6],[1,0.6]],inf)*4,
	\start,                 Pseq([10,20,30,40],inf),
	\end,                  (10000+Pkey(\start)).asInteger,
	\attack,              Pkey(\dur)/2,
	\release,             Pkey(\dur)/4,
)}).play;
Pdef(\bufSaw2,{Pbind(
	\instrument,        \bufSaw,
	\buf,                  Pdefn(\bufnum2),
	\start,                 (Pseq([[10,40],[30,60]],inf)*44100),
	\end,                  Pkey(\dur)*44100+Pkey(\start),
	\freq,                  0.2,
	\dur,                   Pdefn(\beat)*4,
	\amp,                 4,
	\attack,              Pkey(\dur)/4,
	\release,             Pkey(\dur)*0.75,
)}).play;
Pdef(\bufNormal1,{Pbind(
	\instrument,        \bufNormal,
	\buf,                  Pdefn(\bufnum1),
	\start,                 (Pseq([5,15,10,25,40,35,42,48,50,55,60,65,70,75,80,85,
		                                 5,15,10,25,40,35,42,48,50,55,63,67,70,75,80,85,
		                                 5,15,10,25,40,35,42,48,50,55,60,65,70,75,85,90,
		                                 5,15,10,25,40,35,42,48,90,95,100,105,110,115,120,125
	],inf)*44100),
	\end,                  2000+Pkey(\start),
	\freq,                  1.4,
	\dur,                   Pdefn(\beat)*16,
	\amp,                 1,
	\release,             Pkey(\dur)*0.75,
	\attack,              Pkey(\dur)*0.75
)}).play;
Pdefn(\normal1_2_freq, 0.7);
Pdefn(\normal1_2_dur, 0.5);
Pdefn(\bufNormal1_2_amp,6);
Pdef(\bufNormal1_2,{Pbind(
	\instrument,        \bufNormal,
	\buf,                  Pdefn(\bufnum1),
	\start,                Pdefn(\bufNormal1_2_start)*44100,
	\end,                  40000+Pkey(\start),
	\freq,                  0.7,
	\dur,                   Pdefn(\beat)*Pdefn(\normal1_2_dur),
	\amp,                 Pdefn(\bufNormal1_2_amp),
	\release,             Pkey(\dur)*0.25,
	\attack,              1e-5,
)}).play;
Pdefn(\bufNormal1_2_start,
	Pseq([40,35,42,96,50,55,60,65,70,75,73,85,7,18,12,14,
		40,35,42,96,50,55,63,67,70,54,73,85,7,18,12,14,
		40,35,42,96,50,55,88,65,70,66,85,90,7,18,12,14,
		40,35,42,96,90,95,100,105,89,76,32,104,7,18,12,4,
    ],inf));

Pdef(\bomb,{Pbind(
	\instrument,        \bomb,
	\dur,               Pdefn(\beat)*8,
	\amp,               Pseq([0.3],inf),
	\release,          Pkey(\dur)/2
)}).play;
Pdefn( \bufNoise4_amp, 0);
Pdef(\bufNoise4,{Pbind(
	\instrument,        \bufNoise,
	\amp,                 Pseq([Pdefn(\bufNoise4_amp)*3.5,0],inf),
	\buf,                  Pdefn(\bufnum4),
	\start,                 (Pseq([12,13,14,15],inf)*44100),
	\end,                  18000+Pkey(\start),
	\ptrrate,              0.5,
	\dur,                   Pdefn(\beat)/2,
	\attack,              0.1,
	\release,             Pkey(\dur),
)}).play;
Pdef(\highFreqNoise,{Pbind(
	\instrument,        \highFreqNoise,
	\amp,                 Pdefn(\highFreqNoise_amp,0),
	\dur,                   Pdefn(\beat)/8,
	\freq,                 700,
	\attack,              Pkey(\dur)/2,
	\release,              Pkey(\dur)/2
)}).play;
Pdefn(\bufSaw4Sin4_amp,0);
Pdef(\bufSaw4,{Pbind(
	\instrument,        \bufSaw,
	\buf,                  Pdefn(\bufnum4),
	\start,                 (Pseq([[10,40],[20,15]],inf)*44100),
	\end,                  Pkey(\dur)*44100+Pkey(\start),
	\freq,                  1,
	\dur,                   Pdefn(\beat)*2,
	\amp,                 0.8*Pdefn(\bufSaw4Sin4_amp),
	\attack,              0.5,
	\release,             Pkey(\dur)/2,
)}).play;
Pdef(\bufSin4,{Pbind(
	\instrument,        \bufSin,
	\buf,                  Pdefn(\bufnum4),
	\start,                 (Pseq([10,20,30,40],inf)*44100),
	\end,                  Pkey(\dur)*44100*3+Pkey(\start),
	\freq,                  0.3,
	\dur,                   Pdefn(\beat)/2,
	\amp,                 0.6*Pdefn(\bufSaw4Sin4_amp),
	\release,             Pkey(\dur)/4,
	\attack,              Pkey(\dur)*1.5
)}).play;
Pdef(\bufLow4,{Pbind(
	\instrument,        \bufLow,
	\amp,                 1,
	\buf,                  Pdefn(\bufnum4),
	\start,                 (Pseq([[10,15]],inf)*44100),
	\end,                  Pkey(\dur)*2*44100+Pkey(\start),
	\freq,                  0.25,
	\dur,                   Pdefn(\beat)*8,
	\attack,              Pkey(\dur)/4,
	\release,             Pkey(\dur)/2,
)}).play;
Pdef(\bass,{Pbind(
	\instrument,        \bass,
	\freq,              50,
	\amp,               0.6,
	\dur,               8,
)}).play;
Pdef(\part2,{Pbind(
	\instrument,        \pattern_2,
	\dur,               Pdefn(\beat)*2,
	\amp,               0.3
)}).play;
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
Pdef(\bufNoise4).stop;
Pdef(\bufSaw4).stop;
Pdef(\bufLow4).stop;
Pdef(\bufSin4).stop;
Pdef(\bass).stop;