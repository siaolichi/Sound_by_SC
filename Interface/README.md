# Interface

<h1>MidiMix</h1>
- KNOB（利用Pdefn改數值）:
<pre>
~knob[0][0].action_({|butt|
Pdefn(\drum3_amp, butt.value);
});
</pre>
- SLIDER（利用Pdefn改數值）:
<pre>
~slider[0].action_({|butt, mod|
Pdefn(\sound_amp,butt.value);
};
</pre>
- MUTE PAD:
<pre>
~mutePad[0].action_({|butt, mod|
if(butt.value==1,{
//按鈕按下
},{
//按鈕取消
});
};);
</pre>
- RecArmPAD:
<pre>
~recArmPad[0].action_({|butt, mod|
if(butt.value==1,{
//按鈕按下
},{
//按鈕取消
});
};);
</pre>
