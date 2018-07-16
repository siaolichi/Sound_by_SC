SynthDef(\a4_varsawFB, { |amp = 0, width = 0.97,
	lagFreq = 1000, minFreq = 100, maxFreq = 50,
	freqDev = 1, freqRate = 15, dens=1|
	// 8 VarSaws controlling each others frequencies
	var num = 13;
	var saws = [];
	var mod = LocalIn.ar(1);
	var freq = mod.exprange(minFreq, maxFreq);
	var ampcomp = AmpComp.kr(freq, 100).min(1) * amp;
	var strobe;
	width = (width * 2 - 1) ** 0.25 + 1 * 0.5;

	num.do { |i|
		var num1 = num - 1;
		var freqMod = (2 ** LFDNoise3.kr(freqRate, freqDev));
		//var pulse = Pulse.ar(freq-50 * freqMod, Rand(), width);
		var saw = LFTri.ar(freq +20* freqMod, Rand(), width);
		// filter saw
		saw = saw.lag(1/lagFreq);
		//	saw = OnePole.ar(saw, pole ** 1);
		mod = saw;
		saws = saws.add(saw);
	};
	LocalOut.ar(saws.last);
	strobe = LPF.ar(saws, 3).clump(2).sum.abs  < dens;
	strobe = LeakDC.ar(Splay.ar(saws) * strobe.lag(5/lagFreq, 10/lagFreq) * (ampcomp));
	OffsetOut.ar(0,strobe);
}).add;
//Ndef(\a4_varsawFB).addSpec(\maxFreq, [10,200,\lin]);
/*SynthDef(\Winds,{|freq = 100, amp = 0|
	var verb;
	var a6_sound = WhiteNoise.ar(1) + Impulse.ar(freq/4+100,0.04) + VarSaw.ar(200);
	a6_sound = Decay2.ar(MoogFF.ar(a6_sound, freq)*0.5);
	verb = Pan2.ar(AdCVerb2.ar(a6_sound * 0.3),SinOsc.kr(2))*amp;
	// verb + a6_sound;
	Out.ar(0,verb);
}).add;*/
/*SynthDef(\breeze,{|freq = 300, amp = 0.3, freq2=2|
	var verb;
	var a6_sound = (WhiteNoise.ar(1) + VarSaw.ar(LFNoise2.ar(50)*500+700)/2)/2;
	a6_sound = Decay2.ar(MoogFF.ar(a6_sound, LFNoise2.ar(50)*200+400, 1)*0.5);
	verb = Pan2.ar(AdCVerb2.ar(a6_sound * 0.1),SinOsc.kr(freq2))*amp;
	// verb + a6_sound;
	Out.ar(0,verb);
}).add;*/
SynthDef(\inside_pattern,{| dry=0.1, amp_HPF = 5, decaytime = 10, amp = 0|
	var inside_pattern;
	a=HPF.ar(PinkNoise.ar(0.03),80)*amp_HPF;
	inside_pattern = Mix.ar(GVerb.ar({Ringz.ar(a*LFNoise1.kr(0.1.rand),5*Rand(0,10),decaytime)}!20,10,drylevel:dry, mul:0.3));
	inside_pattern = inside_pattern*amp;
	OffsetOut.ar(0, inside_pattern);
}).add;
SynthDef(\new_noise1,{|b = 0.8, amp = 0|
	c=Mix.fill(5,{Saw.ar(1000.rand!2,0.125)*(SinOsc.ar(b+b.rand*(LFPulse.ar(b,0,1000)))+SinOsc.ar(b+b.rand))})*amp;
	OffsetOut.ar(0, c);
}).add;
SynthDef(\new_noise2,{|rand = 10, inR = 0.5, amp = 0|
	a=LFPulse;
	b=VarSaw;
	r=[0.125, 0.25, 0.5];
	f=[1, 3, 5, 8]*rand;
	m=Mix.fill(8, {b.ar(f.choose!2*Lag.ar(a.ar([r.choose+0.1.rand, r.choose+0.1.rand], add:inR),0.5.rand),0, LFPulse.ar([r.choose+0.1.rand, r.choose+0.1.rand]*50)).tanh})*amp;
	OffsetOut.ar(0, m);
}).add;
SynthDef(\moon, { |out = 0, freq = 60, freq2=69, freq3=72, cutoff = 500, amp = 1, gate=1|
	var snd;
	var delay = 0.04;
	freq = freq.midicps;
	freq2 = freq2.midicps;
	freq3 = freq3.midicps;

	freq = freq + SinOsc.kr(freq*1/2, 0, freq/2, 0);
	snd = SinOscFB.ar([freq, freq+1, freq-1, freq2, freq3] * [0.99,1],3)*0.2;
	//snd = snd + SinOscFB.ar(0.99*[freq, freq+1, freq-1, freq2, freq3],0, LFTri.kr(7.13).range(0.00,0.1),5)*0.2;
	snd = RLPF.ar(snd, SinOsc.kr([0.1,4.2], 0, [1700,480], [4000,700,5000])/[20.51,20], SinOsc.ar(0.1,1.5*pi)+1.05)/3;
	//snd = MoogFF.ar(snd, SinOsc.kr(0.08, 0.5), 3, 0);
	snd = snd * EnvGen.ar(Env.dadsr(delay,8, 4,0.5,4,1,2), gate, doneAction:2);
	//snd = [snd , AllpassC.ar(snd, delay, 0.05+SinOsc.ar(0.11).range(0,0.045), 0.3)];
	snd = snd*amp;
	Out.ar(out, snd);
}).add;
SynthDef(\low_pad,{|out = 0, amp = 0.3, freq = 440|
	var t = 1;
	var a ,d, s, r, ratio, dtune,ffreq,vibrate, vibdepth,cutoff,env, fenv, sig, gate, vib;
	vibrate = t/(1..10).choose;
	vibdepth = (90..500).choose.reciprocal;
	dtune = 1e-3;
	cutoff = freq*(1.1,1.2..4).choose;
	ratio = (0.99,0.991..1.01).choose;
	a = 3.0.rand*t*3;
	s = 3.0.rand*t*3;
	r = 4;
	gate = Line.kr(1,0,t);
	env = EnvGen.kr(Env.linen(a,s,r),doneAction:2);
	sig =VarSaw.ar([freq,freq*(1+dtune), freq*(1-dtune)]);
	sig = sig*env;
	sig = Pan2.ar(sig*amp,LFNoise2.ar(1000));
	sig = sig*0.25;
	sig = Compander.ar(sig, sig, 0.75, 1, 0.75, 0.1, 0.4);
	//sig = (sig*0.2) + GVerb.ar(HPF.ar(sig,100), 10, 20,drylevel:3, mul:0.3).tanh;
	sig = Limiter.ar(LeakDC.ar(sig));
	Out.ar(out, sig*amp);
}).add;
SynthDef(\highFreqNoise,{|out = 0, amp = 0.3, freq = 440,arr1=100,arr2=500,arr3=1200, scale=1, thr=0.5,offset =1,attack =1, decay=1,release=1|
	var sig, sig1, sig2,env;
	sig= Klang.ar(`[ [100, freq, freq+200], [0.3, 0.3, 0.3], [pi, pi, pi]], scale, offset) * 0.2;
	//sig2 = Klang.ar(`[ Array.rand(10, 300.0, 1000.0), scale, nil ], scale, offset) * 0.05;
	//sig =  Mix([sig1,sig2]);
	sig = Compander.ar(sig, sig,
        thresh: 0.5,
        slopeBelow: 1,
        slopeAbove: 0.1,
        clampTime: 0.01,
        relaxTime: 0.01
    );
	//sig = Limiter.ar(LeakDC.ar(sig));
	env=EnvGen.kr(Env.perc(attack,release,0.5), doneAction: 2);
	Out.ar(out, Pan2.ar(sig*env*amp,0.5));
}).add;
