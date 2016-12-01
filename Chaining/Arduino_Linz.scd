//Arduino設定
/*
"/dev/tty.usbmodem*".pathMatch;
"/dev/tty.usbserial*".pathMatch;
*/
q = q ? ();
a = ArduinoSMS("/dev/tty.usbmodem*".pathMatch.first, 115200); // enter Baud rate corresponding to Ard. sketch!

a.action = MFdef(\arduino);
//a.action = { arg ... msg; try{ MFdef(\arduino).value( *msg) } }; // catch all errors

MFdef(\arduino).add(\post, { |... msg| msg.postln });
MFdef(\arduino).enable(\post);		// and on again
MFdef(\arduino).disable(\post);		// off


//問題與關機
/*
a.close;
Server.killAll;
*/




/*================================================================
SWITCH Management
================================================================*/
(
~input_2 = Array.series(17,1,1);
~input1 = Array.series(17,1,1);
~temp_imput = Array.series(4,1,1);
~input2 = Array.series(17,1,1);
~check = false ! 16;
MFdef(\arduino).add(\buttons, { |...msg|
	var no1_1, no1_2, no1_3, no1_4, no1_5, no1_6, no1_7, no1_8,no1_9,no1_10,no1_11,no1_12;
	var chanel_1, chanel_2;
	chanel_1 = msg[17];
	chanel_2 = msg[18];
	10.do{|a|
		var b;
		b = msg[a+1];
		~input1.put(a,b);
	};
	4.do{|a|
		var c, d;
		c = msg[a+19];
		d = msg[a+23];
		if(chanel_1 == 1){
			~input2.put(a,c);
		};
		if(chanel_1 == 0){
			~input2.put(a+8,c);
		};
		if(chanel_2 == 1){
			~input2.put(a+4,d);
		};
		if(chanel_2 == 0){
			~input2.put(a+12,d);
		};
	};
		16.do{|a|
		if((~input_2[a] == 0) && (~input2[a] == 1),
			{
				//var name = ("set" ++ (a)).asSymbol;
				var bool = ~check[a].not;
				~check[a] = bool; // binary state
				('check ' ++ a ++' '++ ~check[a]).postln
			};
		);
	};
	if((~check[0] == true)&& ((~input2[0] == 1) && (~input_2[0] == 0)),{
		~intro = Synth(\a1_intro);
	});
	if((~check[0] != true)&& ((~input2[0] == 1) && (~input_2[0] == 0)),{
		~intro.free;
	});
	if((~check[1] == true)&& ((~input2[1] == 1) && (~input_2[1] == 0)),{
		~firstLow = Synth(\a2_firstLow);
		~firstHigh = Synth(\a3_firstHigh);
	});
	if((~check[1] != true)&& ((~input2[1] == 1) && (~input_2[1] == 0)),{
		c = Synth.new(\pattern_6);
		~firstLow.free;
		~firstHigh.free;
	});
	if((~check[2] == true)&& (~input2[2] == 1) && (~input_2[2] == 0),{
		~varsawFB = Synth(\a4_varsawFB);
		~noisePan = Synth(\a5_noisePan);

	}
	);
	if((~check[2] != true)&& (~input2[2] == 1) && (~input_2[2] == 0),{
		~varsawFB.free;
		~noisePan.free;
	});
	if((~check[3] == true)&& ((~input2[3] == 1) && (~input_2[3] == 0)),{
		d = Synth.new(\pattern_6);
		Pdef(\part4).play;
		Pdef(\part5).play;
		~noisePan.free;
	};);
	if((~check[11] == true)&& (~input2[11] == 1&& (~input_2[11] == 0)),{
		//Pdef(\withIntro1).stop;
		//Pdef(\withIntro2).stop;
		Pdef(\part2).play;
		Pdef(\part4).play;
		Pdef(\part5).play;
		Pdef(\part6).play;
	};);
	if((~check[4] == true)&& (~input2[4] == 1) && (~input_2[4] == 0),{
		~inside_pattern = Synth(\inside_pattern);
	};);
	if((~check[4] != true)&& (~input2[4] == 1 ) && (~input_2[4] == 0),{
		~inside_pattern.free;
	};);
	if((~check[5] == true)&& (~input2[5] == 1) && (~input_2[5] == 0),{
		~winds = Synth(\Winds);
		Pdef(\part5).stop;
		Pdef(\part6).stop;
	});
	if((~check[5] != true)&& (~input2[5] == 1) && (~input_2[5] == 0),{
		~winds.free;
	});
	if((~check[6] == true)&& (~input2[6] == 1) && (~input_2[6] == 0),{
		Pdef(\part2).stop;
		Pdef(\part4).stop;
	});
	if((~check[14] != true)&& (~input2[14] == 1) && (~input_2[14] == 0),{
	});
	if((~check[7] == true)&& (~input2[7] == 1) && (~input_2[7] == 0),{
		Pdef(\withIntro1).play;
		Pdef(\withIntro2).play;
	});
	if((~check[7] != true)&& (~input2[7] == 1) && (~input_2[7] == 0),{
		Pdef(\withIntro1).stop;
		Pdef(\withIntro2).stop;
	});
	if((~input2[15] == 1),{
		CmdPeriod.run;~input_2 = Array.series(17,1,1);
		~input1 = Array.series(17,1,1);
		~input2 = Array.series(17,1,1);
		~check = false ! 16;
	});

	no1_1 = ~input1[0].linexp(200,600,0.01,0.8);
	//no1_2 = ~input1[8].linexp(200,800,0,2);
	no1_3 = ~input1[1].linexp(200,600,10,800);
	no1_4 = ~input1[1].linexp(200,600,0.8,2);
	no1_5 = ~input1[9].linexp(200,600,90,2000);
	no1_6 = ~input1[2].linexp(200,600,40,1000);
	no1_7 = ~input1[10].linexp(200,600,1,10);
	//no1_8 = ~input1[3].linexp(200,800,0.1,1);
	no1_9 = ~input1[1].linexp(500,600,0.1,4);
	no1_10 = ~input1[9].linexp(500,600,1,10);
	no1_11 = ~input1[0].linexp(200,600,100,20000);
	no1_12 = ~input1[8].linexp(500,600,0.8,2);
	if(~check[8] == false && (~check[0] == true),{
		~intro.set(\input1_1, no1_1);
		});
/*	if((~check[8] == true) && (~check[8] == 1),{
		Pdef(\withIntro1).play;
		Pdef(\withIntro2).play;
		});*/
	if(~check[9] == false && (~check[1] == true),{
		~firstHigh.set(\ayncFreq1, no1_3);
		~firstHigh.set(\sawFreq1, no1_5);
		~firstHigh.set(\amp, no1_4);
		~firstLow.set(\amp, no1_4);
		});
	if(~check[10] == false && (~check[2] == true),{
		~varsawFB.set(\miniFreq,no1_6);
		~varsawFB.set(\maxFreq,no1_7);
		~varsawFB.set(\amp,10);
		});
	if(~check[12] == false && (~check[4] == true),{
		//~inside_pattern.set(\amp,no1_8);
		~inside_pattern.set(\dry,no1_9);
		~inside_pattern.set(\amp_HPF,no1_10);
		});
	if((~check[13] == false) && (~check[5] == true),{
		~winds.set(\freq,no1_11);
		~winds.set(\gain,no1_12);
		});
	16.do{|a|
		~input_2[a] = ~input2[a];
		//('input  '++~input_2[1]++ ' ' ++~input2[1]).postln;
	};
	//('input  '++~input_2[1]++ ' ' ++~input2[1]).postln;
}
);
);
~input1.postln;
~input2.postln;
~check.postln;