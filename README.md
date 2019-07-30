# Sound_by_Supercollider

## Interface

### MidiMix使用方法
- KNOB(利用Pdefn改數值)
```
~knob[0][0].action_({|butt|
Pdefn(\drum3_amp, butt.value);
});
```
- SLIDER(利用Pdefn改數值)
```
~slider[0].action_({|butt, mod|
Pdefn(\sound_amp,butt.value);
};
```
- MUTE PAD
```
~mutePad[0].action_({|butt, mod|
if(butt.value==1,{
//按鈕按下
},{
//按鈕取消
});
};);
```
- RecArm PAD
```
~recArmPad[0].action_({|butt, mod|
if(butt.value==1,{
//按鈕按下
},{
//按鈕取消
});
};);
```
