SynthDef(\drum_basic,{
	arg amp=1;
	var amp_env, phase_env, phase, freq, dur, p5, p5_verb, verb_env;

	freq = 80;
	amp_env   = EnvGen.ar(Env.perc(1e-6,0.25));
	phase_env = EnvGen.ar(Env.perc(1e-6,0.125));
	verb_env = EnvGen.ar(Env.perc(0.01,0.3), doneAction:2);

	phase = SinOsc.ar(50,0,pi) * phase_env;
	p5 = SinOsc.ar([freq,1.01*freq],phase,5) * amp_env * amp;
	p5_verb = FreeVerb2.ar(p5, p5, 0.5,0.8,0.7);
	OffsetOut.ar(0,p5_verb);
}).add;
SynthDef(\drum,{
	arg amp=1,amp_release = 1, mix=0.3, amp2=0, freq2=64;
	var amp_env, phase_env, phase, freq, dur, p5,p5_2, p5_verb, verb_env;

	freq = 50;
	dur = 0.1;
	amp_env   = EnvGen.ar(Env.perc(1e-6, amp_release));
	phase_env = EnvGen.ar(Env.perc(1e-6,0.25));
	verb_env = EnvGen.ar(Env.perc(1e-6,0.3), doneAction:2);

	phase = SinOsc.ar(50,0,pi) * phase_env;
	p5 = Mix([WhiteNoise.ar(0.3),Pulse.ar([freq2,1.01*freq2],phase,7)]) * amp_env * amp;
	p5_2= SinOsc.ar([freq,1.01*freq],phase,5) * amp_env*2;
	p5_verb = FreeVerb2.ar(p5, p5, mix,0.7,0.7);
	OffsetOut.ar(0,Mix([p5_verb,p5_2*amp2])/6);
}).add;
SynthDef(\drum1, {|out=0, t_trig=1, freq = 1, freqMul=4, decay=0.5, fdecay=0.5, rq=0.8, amp=0.7, pan=0,roomsize, revtime, damping, inputbw, spread = 15, drylevel, earlylevel, taillevel|
	var snd, fenv, env;
	pan = LFNoise0.ar(20);
	env = EnvGen.ar(Env.perc(0.05, decay, curve:-8), t_trig, doneAction:2);
	fenv = EnvGen.ar(Env.perc(0.05, fdecay, curve:-8), t_trig, doneAction:0);
	snd = BPF.ar( LFPulse.ar(62.midicps), freq * freqMul * fenv, rq, 1);
	Compander.ar(snd, snd,
		thresh: 0.5,
		slopeBelow: 0.1,
		slopeAbove: 1,
		clampTime: 0.01,
		relaxTime: 0.01,
		mul:3
	);
	OffsetOut.ar(0, GVerb.ar(
        Pan2.ar(snd * amp * env, pan),
        roomsize,
        revtime,
        damping,
        inputbw,
        spread,
        drylevel.dbamp,
        earlylevel.dbamp,
        taillevel.dbamp,
        roomsize, 0.3) + Pan2.ar(snd * amp * env, pan))
}).add;
SynthDef(\drum2, {|out=0, t_trig=1,freq, freqMul=4, decay=0.1, ffreq=1000, rq=0.3, amp=0.4, pan=0|
	var snd, env = EnvGen.ar(Env.perc(1e-9, decay, curve:-8), t_trig, doneAction:2);
	snd = BPF.ar( WhiteNoise.ar(10), freq * freqMul + 100, rq)
	+ SinOsc.ar(freq/2)!2;
	OffsetOut.ar(out, Pan2.ar(LPF.ar(snd, ffreq, amp * env * 0.5), pan));
}).add;
SynthDef(\drum3,{|out=0,attack=1, t_trig=1, freq, freqMul=4, decay=0.1, fdecay=0.02, rq=0.2, amp=0,amp2=0,amp_high=0|
	var snd, fenv, env = EnvGen.ar(Env.perc(attack, decay, curve:-8), t_trig);
	fenv = EnvGen.ar(Env.perc(attack/8, fdecay, curve:-4), t_trig, doneAction:2);
	snd = BPF.ar( Pulse.ar([100,120,300],) ! 2, freq * freqMul * fenv + 100, rq);
	snd = snd*amp*2+  (Pan2.ar(Klank.ar(`[[300,360], nil, [1, 0.8, 0.7, 0.6,0.7,0.5]], Impulse.ar([10, 12], 1, 0.5)),1.0.rand)*amp2);
	OffsetOut.ar(out, snd.softclip * env*0.3);
}).add;
SynthDef(\drum4,{|out=0, t_trig=1,attack=0.01, freq=400, decay=0.5, fdecay=0.2, rq=0.2, amp=0.7, freqMul=2|
	var env = EnvGen.ar(Env.perc(attack, decay, curve:-4), t_trig);
	var fenv = EnvGen.ar(Env.perc(attack, fdecay, curve:-4), t_trig, doneAction:2);
	var snd = BPF.ar( GrayNoise.ar(10) ! 2, freq * freqMul * fenv + 100, rq);
	snd = snd + SinOsc.ar(freq*2,0,fenv);
	OffsetOut.ar(out, snd.softclip * amp * env*0.5);
}).add;