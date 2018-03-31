//-----------------Still Need to Text
/*
(
a = SynthDef(\src2x2, {
    Out.ar(0,
        Decay.ar(Impulse.ar(1), 0.25, LFCub.ar(1200, 0, 0.1)) ! 2 +
        Pan2.ar(
            Decay.ar(Impulse.ar(1, pi), 0.1, WhiteNoise.ar(0.1)),
            LFNoise1.kr(0.5).range(-1, 1)
        )
    )
}).play
)

*/





(
//drum
"/Users/Siao/Desktop/SS2017/Rundgang/Drum.scd".load;
//Pad
"/Users/Siao/Desktop/SS2017/Rundgang/Pad.scd".load;
//Buffer
"/Users/Siao/Desktop/SS2017/Rundgang/Buffer_Techno.scd".load;
SynthDef(\alien,
	{ arg out = 0, freq=2000, freqFM=200, fmi = 100.5, decay=0.5, amp = 0.5, pan = 0, attack = 1, freqDecay = 8;
		var window, ratio=0.1;
		freq = 300;
		window = Env.perc(attack, decay, amp);
		OffsetOut.ar(out, Pan2.ar(VarSaw.ar( LFNoise0.ar(freqFM) * fmi +freq), pan) * EnvGen.ar(window, doneAction:2)*Saw.kr(10))
	}
).add;
SynthDef(\alien2,
	{ arg out = 0, freq=2000, freqFM=200, fmi = 100.5, decay=0.5, amp = 0.5, pan = 0, attack = 1, freqDecay = 16;
		var window, ratio=0.1;
		freq = LFNoise1.ar(0.1)*800+300;
		window = Env.perc(attack, decay, amp);
		OffsetOut.ar(out*1.5, Pan2.ar(SinOsc.ar( SinOsc.ar(freqFM) * fmi +freq), pan) * EnvGen.ar(window, doneAction:2)*LFPulse.kr(10))
	}
).add;
SynthDef(\blingbling,
	{ arg out=0, freq=440, decay=0.05, pan=0, amp=0.2;
		var env = EnvGen.kr(Env.perc(0.01, decay, amp), doneAction:2);
		OffsetOut.ar(out, Pan2.ar(FSinOsc.ar(freq, 0, env), pan))
}).add;

SynthDef(\tzatzatza,{
	arg amp=1, t_gate = 1, dura = 0.3, freq, mul4sound=0.8,mul4LFPar=0,attack=0.01;
	var amp_env, phase_env, phase, pattern6, blip_env;
	amp_env   = EnvGen.ar(Env.perc(attack,dura/2,amp));
	phase_env = EnvGen.ar(Env.perc(attack,dura/2,0.5));
	blip_env = EnvGen.ar(Env.perc(attack,dura/2,1,-4,0.5), doneAction:2);
	pattern6 =
	GVerb.ar((
		VarSaw.ar([freq, 1.01 * freq],mul:mul4sound)+
		Blip.ar(freq, 100,mul:1.25-mul4sound)*blip_env), 5, 0.125, spread: 2, drylevel:0.6, maxroomsize:50, mul:2);
	Compander.ar(pattern6, pattern6,
		thresh: mul4LFPar,
		slopeBelow: 1,
		slopeAbove: 0.1,
		clampTime: 0.01,
		relaxTime: 0.01
	);
	OffsetOut.ar(0,pattern6*amp_env);
};).add;
SynthDef(\kakaka,{
	arg amp=1, t_gate = 1, dura = 0.3, freq;
	var amp_env, phase_env, phase, pattern6, blip_env;
	amp_env   = EnvGen.ar(Env.perc(1e-5,dura,amp));
	phase_env = EnvGen.ar(Env.perc(1e-5,dura,0.5));
	blip_env = EnvGen.ar(Env.perc(1e-5,dura,1,-4,0.5), doneAction:2);
	pattern6 =
	GVerb.ar((WhiteNoise.ar([freq, 1.01 * freq],mul:0.5)+
		Blip.ar(freq, 100)*blip_env), 5, 0.125, spread: 2, drylevel:0.6, maxroomsize:50, mul:3);
	Compander.ar(pattern6, pattern6,
		thresh: 0.6,
		slopeBelow: 1,
		slopeAbove: 0.1,
		clampTime: 0.01,
		relaxTime: 0.01
	);
	OffsetOut.ar(0,pattern6*amp_env);
};).add;
//Pattern Source
SynthDef(\hi_hill,{|amp = 1, freq = 200|
	var env = EnvGen.ar(Env.sine(0.8,0.5),doneAction:2);
	var s1 = Pan2.ar({(Blip.ar(freq,300,3)+SinOsc.ar(200,0,3))*(env+0.5)}, SinOsc.ar(3,0,4).range(-1, 1), LFNoise2.ar(200)
	)*amp;
	GVerb.ar(s1,30,10,1,1,100,taillevel: LFNoise1.ar(1));
	OffsetOut.ar([0,1],s1);
}).add;
SynthDef(\pattern_3,{|chaos = 3.5, midi = 32, leng = 8, amp = 0.25|
	var env = EnvGen.ar(Env.sine(leng*3,amp), doneAction:2);
	var p3 = Pan2.ar(
		{(SyncSaw.ar(midi.midicps,midi.midicps, 0.3 ,0.5)*LFTri.kr(15,30)+LFNoise1.ar(0.001))*env},
		LFNoise1.ar(1).range(-1, 1));
	p3 = GVerb.ar(p3,30,2,0.8,taillevel: LFNoise1.ar(1));
	OffsetOut.ar([0,1],p3);
}).add;
SynthDef(\bass,{| atk = 0.01, dur = 4, freq = 50, amp=0.6 |
	var bass = BPF.ar(LFSaw.ar(freq), freq, 2, mul: EnvGen.kr( Env.perc( atk, dur-atk, amp, 6 ))
	)+PinkNoise.ar(EnvGen.kr( Env.sine(8,0.4), doneAction: 2)) ! 2;
	OffsetOut.ar([0,1],bass);
}).add;
SynthDef(\highBlip,{|dur = 4, amp = 0.3|
	var high;
	var env = EnvGen.ar(Env.perc(0.000001,dur/32,amp),doneAction:2);
	high = Blip.ar(880!2,100,env)+Pulse.ar(880!2,0.5,env);
	OffsetOut.ar([0,1],high);
}).add;
SynthDef(\bell, { |amp = 0.3, dur = 8|
	var env = EnvGen.ar(Env.sine(dur,0.3),doneAction:2);
	var bell = Klank.ar(`[[800, 1071, 1353, 1723], nil, [1, 1, 1, 1]],
		Dust.ar(8,amp)*env!2);
	var verbBell = GVerb.ar(bell,30,5,0.8,0.8,30,0.8,0.7,0.7,mul:0.5);
	OffsetOut.ar([0,1],verbBell);
}).add;
SynthDef(\new_melody,{ |amp, midi1, midi2, dur|
	var env, melody1, melody2;
	env = EnvGen.ar(Env.perc(1e-4,dur/5,0.3), doneAction:2);
	melody1 = Pan2.ar(VarSaw.ar(midi1.midicps, WhiteNoise.kr(1),Rand(0.3,0.8))*env,
		LFNoise0.kr(500,1),LFNoise0.kr(500,1,1));
	melody2 = Pan2.ar(VarSaw.ar(midi2.midicps, WhiteNoise.kr(1),Rand(0.3,0.8))*env,
		LFNoise0.kr(500,1),LFNoise0.kr(500,1,1));

	OffsetOut.ar([0,1],[melody1,melody2]*amp);
}).add;
SynthDef(\noisePan,{ |freq=30, noiseAmp=0.25, midi=30, amp=1, dur=0.125, in=0, amp2=0|
	var noiseOrig, noisePan, env;

	env = EnvGen.ar(Env.sine(dur,amp),doneAction:2);
	noiseOrig = WhiteNoise.ar(1);
	noisePan = Resonz.ar(noiseOrig ,midi.midicps, 1, 2)*env;
	OffsetOut.ar(in,noisePan);
}).add;
SynthDef(\beep,{|vol = 0.1, freq = 880, volu = 0.01, amp = 0.1|
	var filter, oscillo, env1, env2, env3, lfo1, lfo2;

	env3 = EnvGen.ar(Env.perc(0.001,0.1),doneAction:2);
	oscillo = HPZ1.ar(VarSaw.ar(freq, 0, 0.2, 0.02));
	filter = Slope.ar( in: oscillo, mul:0.01 )*env3;
	OffsetOut.ar([0,1],filter);
}).add;
SynthDef(\pattern_4,{
	arg amp=0.4;
	var amp_env, cut_freq, dur, p4;

	cut_freq = 6000;
	dur = [0.0625, 0.125, 0.25].choose;

	amp_env = EnvGen.ar(Env.perc(1e-7, dur), doneAction:2);
	p4 = HPF.ar( {WhiteNoise.ar}.dup * amp_env, cut_freq ) * amp;
	OffsetOut.ar([0,1],p4);
}).add;
SynthDef(\bomb,{
	arg amp=1, t_gate = 1,release=0.1;
	var amp_env, phase_env, phase, freq, dura, pattern6, blip_env;

	freq = 10.rand+20;

	amp_env   = EnvGen.ar(Env.perc(1e-5,release));
	phase_env = EnvGen.ar(Env.perc(1e-5,release,0.5));
	blip_env = EnvGen.ar(Env.perc(1e-5,release,1,-4), doneAction:2);
	phase = Saw.ar(20,0,pi) * phase_env;
	pattern6 =
	GVerb.ar((PinkNoise.ar([freq, 1.01 * freq], phase) * amp_env * amp+
		Blip.ar(20,200)*blip_env), 5, 0.125, spread: 2, drylevel:0.6, maxroomsize:50, mul:0.25);
	Compander.ar(pattern6, pattern6,
		thresh: 0.6,
		slopeBelow: 1,
		slopeAbove: 0.1,
		clampTime: 0.01,
		relaxTime: 0.01
	);
	OffsetOut.ar(0,Pan2.ar(pattern6, 0.5,0.5));
};).add;
SynthDef(\scratch,{|amp = 0.3|
	var ctl, scratch, scratch2, scratch_verb;
	ctl = RLPF.ar(Pulse.ar(3), 25, 0.003);
	scratch = Saw.ar(ctl*330)*Pulse.ar(0.25, 0.8, 0.1)*amp*SinOscFB.kr(20);
	scratch2 = Saw.ar(330)*Pulse.ar(0.25, 0.4, 0.5)*Pulse.ar(8, 0.6, 0.7)*amp*SinOscFB.kr(20);
	scratch_verb = FreeVerb2.ar(scratch,scratch2, 0.3,1,0.8);
	OffsetOut.ar([0,1],scratch_verb);
}).add;
SynthDef(\pattern_2,{|amp = 1|
	var env = EnvGen.ar(Env.sine(0.7,0.7),doneAction:2);
	var s1 = Pan2.ar({(Blip.ar(130,300,3)+SinOsc.ar(130,0,3))*(env+0.5)}, SinOsc.ar(3,0,4).range(-1, 1), LFNoise2.ar(400)
	)*amp;
	GVerb.ar(s1,30,10,1,1,100,taillevel: LFNoise1.ar(1));
	OffsetOut.ar(0,s1);
}).add;


//單聲短音
SynthDef(\bssine,{ |out=0, t_trig=1, freq=440, decay=0.2, amp=0.9|
	var env, snd;
	env = EnvGen.ar(Env.perc(1e-3,decay), t_trig, doneAction:2);
	snd = SinOsc.ar(freq*[1,1.01], mul:0.5);
	OffsetOut.ar(out, snd * env * amp);
}).add;

SynthDef(\bspulse,{ |out=0, t_trig=1, pan=0, freq=200, width=0.5, decay=0.1, amp=0.6|
	var env, snd;
	env = EnvGen.ar(Env.perc(1e-2,decay), t_trig, doneAction:2);
	snd = Pulse.ar(freq, width);
	OffsetOut.ar(out, Pan2.ar(snd * env * amp * 0.5));
}).add;

SynthDef(\bsfm, {| out=0, t_trig=1, freq=1040, modfreq=100, modindex=1, decay=0.2, amp=0.3|
	var snd, env = EnvGen.ar(Env.perc(0.01, decay ), t_trig, doneAction:2);
	snd = PMOsc.ar(freq, modfreq, modindex,SinOsc.kr(0.3,[0, 1],pi));
	OffsetOut.ar(out, snd * env * amp);
}).add;

SynthDef(\bsfnoise, {| out=0, t_trig=1, freq=1000, rq=0.1, pan=0, decay=0.2, amp=0.3|
	var snd, env = EnvGen.ar(Env.perc(0.001, decay ), t_trig, doneAction:2);
	snd = BPF.ar(WhiteNoise.ar(4), freq, rq); // freq is filter cutoff frequency here, rq is the reciprocal of q (bandwith of filter)
	OffsetOut.ar(out, Pan2.ar(snd * env * amp, pan));
}).add;

SynthDef(\bsfnoise2, {| out=0, t_trig=1, freq=1000, rq=0.1, decay=0.2, fdecay=0.04, amp=0.3, pan=0|
	var snd, fenv, env = EnvGen.ar(Env.perc(0.001, decay ), t_trig, doneAction:2);
	fenv = EnvGen.ar(Env.perc(1e-5, fdecay, curve:-4), t_trig, doneAction:0);
	snd = BPF.ar(WhiteNoise.ar(4), freq*(1+fenv), rq); // freq is filter cutoff frequency here, rq is the reciprocal of q (bandwith of filter)
	OffsetOut.ar(out, Pan2.ar(snd * env * amp, pan));
}).add;

SynthDef(\honky,{ |out=0, t_trig=1, freq, decay=0.1, amp=0.9, pan=0|
	var snd, env = EnvGen.ar(Env.perc(1e-3,decay), t_trig, doneAction:2);
	snd = SinOsc.ar(freq).cubed.cubed;
	OffsetOut.ar(out, Pan2.ar(snd * amp * env, pan));
}).add;
SynthDef(\ana1, {|out=0, t_trig=1, freq=100, sfreq=100, pfreq, pwidth=0.2, decay=0.3, pdecay=0.07,
	ffreq=700, rq=0.3, amp=0.3|
	var aenv, penv, osc1, osc2, filtd;
	aenv = EnvGen.ar(Env.perc(0.01, rrand(decay/2,decay*2)), t_trig, doneAction: 2);
	penv = 1 + EnvGen.ar( Env.perc(0.01, pdecay), t_trig, timeScale:0.2, levelScale:-0.1, doneAction: 0);
	pwidth = pwidth * SinOsc.kr(0.1, [0, pi], 0.24, 0.25);
	sfreq = freq;
	pfreq = freq * SinOsc.kr([0.5, 1.333],0,0.01,1);
	osc1 = VarSaw.ar(sfreq*penv,0,pwidth);
	osc2 = LFPulse.ar((pfreq?sfreq)*penv,0,pwidth);
	filtd = RLPF.ar(Mix([osc1, osc2]), ffreq, rq);
	OffsetOut.ar(out, filtd * aenv * amp * 0.7)
}).add;

SynthDef(\ana2, {|out=0, t_trig=1, freq=100, sfreq=100, pfreq, pwidth=0.2, decay=0.3,
	pdecay=0.07, ffreq=700, rq=0.3, amp=0.4|
	var aenv, penv, osc1, osc2, filtd;
	aenv = EnvGen.ar(Env.perc(0.01, rrand(0.02,decay)), t_trig, doneAction:  2);
	penv = 1 + EnvGen.ar(Env.perc(0.01, pdecay), t_trig, timeScale:0.2, levelScale:-0.1, doneAction: 0);
	pwidth = pwidth * SinOsc.kr(0.1, [0, pi], 0.24, 0.25);
	sfreq = freq  * TChoose.kr(t_trig, [1.5, 1.0, 0.5, 2]);
	pfreq = freq * SinOsc.kr([0.5, 1.333],0,0.01,1) * TChoose.kr(t_trig, [1.5, 1.0, 0.5, 2]);
	osc1 = VarSaw.ar(sfreq*penv,0,pwidth);
	osc2 = LFPulse.ar((pfreq?sfreq)*penv,0,pwidth);
	filtd = RLPF.ar(Mix([osc1, osc2]), ffreq, rq);
	OffsetOut.ar(out, filtd * aenv * amp * 0.5)
}).add;


SynthDef(\fm1, {| out=0, t_trig=1, freq=1040, decay=0.3, amp=0.2|
	var snd, env = EnvGen.ar(Env.perc(0.01, freq.reciprocal * 200 * decay ), t_trig, doneAction: 2);
	snd = PMOsc.ar(freq, freq*0.5, 2*TExpRand.kr(0.5, 4, t_trig),SinOsc.kr(0.3,[0,1],pi));
	OffsetOut.ar(out, snd * env * amp);
}).add;

SynthDef(\fm2, {| out=0, t_trig=1, freq=1040, decay=0.09, amp=0.6|
	var snd, env = EnvGen.ar(Env.perc(0.01,decay*LFNoise2.kr(0.1,0.1,1)), t_trig, doneAction: 2);
	snd = RLPF.ar(
		PMOsc.ar(freq, freq * IRand(2,4)/2, TRand.kr(0.5, 3, t_trig),0),
		SinOsc.kr([0.1, 0.11]).range(400, 1900),
		0.4
	);
	OffsetOut.ar(out, snd * env * amp);
}).add;

SynthDef(\sine,{ arg out, freq, attack=0.01, decay=1, amp=1, pan;
	var snd, env, u=1;
	env = EnvGen.kr(Env.perc(attack, decay), 1, doneAction:2);
	snd = SinOsc.ar(freq, 0, amp * env);
	Out.ar(out, Pan2.ar(snd, pan));
}).add;

SynthDef(\pmosc,{ arg out, freq=200, decay=1, amp=1, pan=0.5;
	var env, u=1;
	env = EnvGen.kr(Env.perc(0.01, decay), 1, doneAction:2);
	5.do { var d; d = exprand(0.01, 1); u = SinOsc.ar(d * 300, u, rrand(0.1,1.2) * d, 1) };
	Out.ar(out, Pan2.ar(SinOsc.ar(u + 1 * freq, 0, amp * env), pan));
}).add;

SynthDef(\saw,{ arg out, freq, attack=0.01, decay=1, ffMul=0, amp=1, pan;
	var snd, env, u=1;
	env = EnvGen.kr(Env.perc(attack, decay), 1, doneAction:2);
	snd = LPF.ar(LFSaw.ar(freq, 0, amp * env), freq*(ffMul+1));
	Out.ar(out, Pan2.ar(snd, pan));
}).add;
SynthDef(\pandeiro1, { |out, amp = 0.1, pan, dur, drumres = 10, decay = 0.5, beldec = 0.5, belamp = 0.5|
	var snd = GrayNoise.ar();
	var filtFreq = amp.linlin(0.025, 0.1, 6000, 12000);
	var env = EnvGen.ar(Env.perc(dur*1.5, decay, amp,4));
	var env2 = EnvGen.ar(Env.perc(dur*1.5, decay + 0.1, amp,4), doneAction: 2);
	var filtered = RHPF.ar(snd, Rand(50,100), 0.3/drumres);
	var bellz = Klank.ar(`[
		[3567, 4200, 4765, 5100, 5689],
		belamp,
		beldec,
	], Dust2.ar(4000) * env2).tanh;
	Out.ar(out, Pan2.ar(
		filtered * env + (bellz),
		pan));
}).add;


);


(
Pdef(\bomb,{Pbind(
	\instrument,        \bomb,
	\dur, 				Pdefn(\beat)*2,
	\leng,              Pkey(\dur),
	\amp,               Pseq([0,1],inf),
)}).play;
Pdef(\hi_hill,{Pbind(
	\instrument,        \pattern_4,
	\dur, 				0.0625,
	\leng,              Pkey(\dur),
	\amp,               Pseq([0,1],inf),
	\freq,              Pseq([[60,100]],inf);
)}).play;
Pdef(\withIntro1,{Pbind(
	\instrument,        \pattern_3,
	\dur, 				4,
	\leng,              Pkey(\dur)/8,
	\midi,   			Pxrand([36,40,43,45],inf),
	\amp,               0.8
)}).play;
Pdef(\withIntro2,{Pbind(
	\instrument,        \pattern_3,
	\dur, 				Prand([4,8],inf),
	\leng,              Pkey(\dur),
	\midi,   			Prand([84,88,91,93],inf),
	\amp,               0.5
)}).play;
Pdef(\beep,{Pbind(
	\instrument,        \beep,
	\dur,               Pseq(([3,1]), inf),
	\freq,              660,
	\amp,               0.005,
)}).play;
Pdef(\bass,{Pbind(
	\instrument,        \bass,
	\freq,              50,
	\amp,               0.6,
	\dur,               8,
)}).play;
Pdef(\highBlip,{Pbind(
	\instrument,        \highBlip,
	\freq,              [880,1200,660],
	\amp,               Pseq([0.4],inf),
	\dur,               0.33,
)}).play;
Pdef(\bell,{Pbind(
	\instrument,        \bell,
	\amp,               [0,0.3],
	\dur,               4,
)}).play;
Pdef(\drum1,{Pbind(
	\instrument,       \drum1,
	\dur,              0.125,//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,              1
)}).play;
Pdef(\drum,{Pbind(
	\instrument,       \drum,
	\dur,              0.5,//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,              1
)}).play;
Pdef(\drum2,{Pbind(
	\instrument,       \drum2,
	\dur,              0.125,//Pseq([2,2,4,1,4,1,2,1,4,1,4,4,8,2,2,4,1,3,2,8,1,1,1,1]*0.125,inf),
	\amp,              1
)}).play;
Pdef(\new_melody,{Pbind(
	\instrument,        \new_melody,
	\dur, 				Prand([0.125,0.0625],inf),
	\leng,              Pkey(\dur)*2,
	\midi1,   			Prand([36,40,43,45],inf),
	\midi2,   			Prand([84,88,91,93],inf),
	\amp,               0.7
)}).play;
Pdef(\noisePan,{Pbind(
	\instrument,       \noisePan,
	\dur,              Prand([0.25,0.125],inf),
	\midi,             Pxrand([36,40,43,45,84,88,91,93],inf),
	\amp,              Prand([0.7,0.5],inf),
	\amp2,             0
)}).play;
Pdef(\noisePan2,{Pbind(
	\instrument,       \noisePan,
	\dur,              Prand([0.25,0.125],inf),
	\midi,             Pxrand([36,40,43,45],inf),
	\amp,              Prand([0.5,0.7,0.9],inf),
	\in,               1,
)}).play;
Pdef(\part2,{Pbind(
	\instrument,        \pattern_2,
	\dur,               Pseq(1!8, inf),
	\amp,               1.5
)}).play;
Pdef(\bssine,{Pbind(
	\instrument,        \bssine,
	\dur, 				Prand([0.25,0.25],inf),
	\leng,              Pkey(\dur),
	\amp,               0.2,
	\freq,              Prand([3800,4000], inf)
)}).play;
Pdef(\bspulse,{Pbind(
	\instrument,        \bssine,
	\dur, 				Pseq([1,2,4],inf),
	\leng,              Pkey(\dur)*1.2,
	\amp,               0.5,
	\freq,              Pexprand(300,500,inf),
	\width,            0.02,
	\decay,            2
)}).play;
Pdef(\pandeiro1,{Pbind(
	\instrument,        \pandeiro1,
	\dur, 				Prand([1,2,4],inf),
	\leng,              Pkey(\dur)*2,
	\amp,               0.5,
	\decay,            Pkey(\dur)
)}).play;
Pdef(\drum).stop;
Pdef(\drum1).stop;
Pdef(\drum2).stop;
Pdef(\drum3).stop;
Pdef(\bomb).stop;
Pdef(\hi_hill).stop;
Pdef(\withIntro1).stop;
Pdef(\withIntro2).stop;
Pdef(\beep).stop;
Pdef(\bass).stop;
Pdef(\highBlip).stop;
Pdef(\bell).stop;
Pdef(\new_melody).stop;
Pdef(\noisePan).stop;
Pdef(\noisePan2).stop;
Pdef(\part2).stop;
Pdef(\bssine).stop;
Pdef(\bspulse).stop;
Pdef(\pandeiro1).stop;
)



