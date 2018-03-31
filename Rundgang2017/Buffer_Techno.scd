(
fork{
	Pdefn(\beat, 60/120);
	~bo1 = Buffer.read(s, "/Users/Siao/Google 云端硬盘/SunMoonLake/grandma/Gramdma3.wav");
	~bo2 = Buffer.read(s, "/Users/Siao/Google 云端硬盘/SunMoonLake/grandma/Gramdma4.wav");
	~bo3 = Buffer.read(s, "/Users/Siao/Google 云端硬盘/SunMoonLake/grandma/Gramdma5.wav");
	~bo4 = Buffer.read(s, "/Users/Siao/Google 云端硬盘/SunMoonLake/grandma/Gramdma6.wav");
	s.sync;
	~bufnumbo1 = ~bo1.bufnum;
	~bufnumbo2 = ~bo2.bufnum;
	~bufnumbo3 = ~bo3.bufnum;
	~bufnumbo3 = ~bo3.bufnum;
	s.sync;
	Pdefn(\bufnum1, ~bufnumbo1);
	Pdefn(\bufnum2, ~bufnumbo2);
	Pdefn(\bufnum3, ~bufnumbo3);
	Pdefn(\bufnum4, ~bufnumbo4);
	//Env.dadsr(1,0.005,0.5*0.2,0.5,0.5*0.7,curve: 2).plot
	SynthDef.new(\bufNormal,{
		|amp = 1, out = 0, buf, freq=1, start, end, rate=1,adelay=0,attack=0.1,release=1,room=2,damp=4|
		var sig,ptr,env;
		ptr = Phasor.ar(0, BufRateScale.ir(buf)*rate, start, end)*freq;
		//ptr = LFDNoise1.ar(freq).range(start, end);
		//ptr = SinOsc.ar(freq,3pi/2).range(start, end);
		sig = BufRd.ar(2, buf, ptr);
		sig = FreeVerb.ar(sig, 0.5,room,damp,4);
		//env = EnvGen.kr(Env.dadsr(adelay,attack,release*0.2,0.5,release*0.7), doneAction:2);
		env = EnvGen.kr(Env.perc(attack,release,1 ,2), doneAction:2);
		sig = sig*amp*env;
		LPF.ar(sig, 700);
		HPF.ar(sig, 100);
		Compander.ar(sig, sig,
			thresh: 1,
			slopeBelow: 1,
			slopeAbove: 0.1,
			clampTime: 0.01,
			relaxTime: 0.01
			,mul:4);
		Out.ar(out, sig);
	}).add;
	SynthDef.new(\bufLow,{ |amp = 1, out = 0, buf, freq=1, start, end, rate=0.1,attack=0.1,release=1|
		var sig,ptr,env;
		ptr = Phasor.ar(0, BufRateScale.ir(~bo3.bufnum)*freq, start, end);
		//ptr = LFDNoise1.ar(freq).range(start, end);
		//ptr = SinOsc.ar(freq).range(start, end);
		sig = BufRd.ar(2, buf, ptr);
		sig = sig*amp*2;
		sig = FreeVerb.ar(sig, 0.7,10,1.3,2);
		sig = Mix([sig*SinOsc.ar(40),sig*LFNoise2.ar(50)])*4;
		env = EnvGen.kr(Env.perc(attack,release,1 ,-6), doneAction:2);
		Out.ar(out, sig*env);
	}).add;
	SynthDef.new(\bufSin,{ |amp = 1, out = 0, buf=6, freq=1, start, end, rate=1, sawFreq = 10, pulseFreq = 300, attack=1, release=5|
		var sig,ptr,env;
		//ptr = Phasor.ar(0, BufRateScale.kr(buf)*rate, start, end);
		//ptr = LFDNoise1.ar(freq).range(start, end);
		ptr = SinOsc.ar(freq,3pi/2).range(start, end);
		sig = BufRd.ar(2, buf, ptr);
		sig = sig*amp;
		//sig = FreeVerb.ar(sig, 0.7,1,0.8);
		sig = sig*VarSaw.ar(10)*2;
		env = EnvGen.kr(Env.perc(attack,release,1 ,-4), doneAction:2);
		//sig = sig*LFPulse.ar(300);
		HPF.ar(sig, 80);
		Out.ar(out, sig*env);
	}).add;
	SynthDef.new(\bufNoise,{ |amp = 1, out = 0, buf, freq=1, start, end, ptrrate=1,attack=1, release=5|
		var sig,ptr,env;
		ptr = Phasor.ar(0, BufRateScale.ir(buf)*ptrrate, start, end);
		//ptr = LFNoise1.ar(freq)* BufFrames.ir(buf);
		//ptr = SinOsc.ar(freq,3pi/2).range(start, end);
		sig = BufRd.ar(2, buf, ptr);
		sig = sig*amp;
		//sig = FreeVerb.ar(sig, 0.7,1,0.8);
		sig = sig*VarSaw.ar(30)*LFNoise1.ar(50)*2;
		//sig = sig*LFPulse.ar(300);
		env = EnvGen.kr(Env.perc(attack,release,1 ,-4), doneAction:2);
		Out.ar(out, sig*env);
	}).add;
	//a  = Synth.new(\bufNoise, [\start, 0, \end, 441000, \release, 44100]);
	SynthDef.new(\bufSaw2,{ |amp = 1, out = 0, buf, freq=1, start, end, rate=1,attack=0.1,release=0.25|
		var sig,ptr,env;
		//ptr = Phasor.ar(0, BufRateScale.kr(buf)*rate, start, end);
		ptr = VarSaw.ar(freq).range(start, end);
		//ptr = SinOsc.ar(freq,3pi/2).range(start, end);
		sig = BufRd.ar(2, buf, ptr);
		sig = sig*amp;
		sig = FreeVerb.ar(sig, 0.7,1,0.8);
		sig = sig*VarSaw.ar(10);
		sig = sig*LFPulse.ar(300);
		env = EnvGen.kr(Env.perc(attack,release,2 ,-4), doneAction:2);
		Compander.ar(sig, sig,
			thresh: 1,
			slopeBelow: 1,
			slopeAbove: 0.1,
			clampTime: 0.01,
			relaxTime: 0.01
		);
		Out.ar(out, sig*env*4);
	}).add;
	SynthDef.new(\bufSaw,{ |amp = 1, out = 0, buf, freq=1, start, end, rate=1,attack=0.1,release=0.25|
		var sig,ptr,env;

		//ptr = Phasor.ar(0, BufRateScale.kr(buf)*rate, start, end);
		ptr = VarSaw.ar(freq).range(start, end);
		//ptr = SinOsc.ar(freq,3pi/2).range(start, end);
		sig = BufRd.ar(2, buf, ptr);
		sig = sig*amp;
		sig = FreeVerb.ar(sig, 0.7,1,0.8);
		env = EnvGen.kr(Env.perc(attack,release,2 ,-4), doneAction:2);
		sig = sig*(LFPulse.ar(10)*0.2);
		Compander.ar(sig, sig,
			thresh: 1,
			slopeBelow: 1,
			slopeAbove: 0.1,
			clampTime: 0.01,
			relaxTime: 0.01
		);
		Out.ar(out, sig*env*4);
	}).add;


};
)

