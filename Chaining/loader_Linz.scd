SerialPort.closeAll;
Server.killAll;
//s.options.memSize = number_of_kb;
s.options.memSize = 3.pow(16);
s.reboot;
s.options.memSize

(
//q=q?();
//s.boot;	s.latency_(nil);
s.scope(2);
//x = NdefMixer(s);
//x.skipjack.dt = 0.015;
);
(
"Sound*".loadRelative;
"Arduino_Linz*".loadRelative;
"p2_multiGui*".loadRelative;
)

a.close

s.freeAll