## Memory map:
```
0x0000 - 0x7FFF : RAM (32k)
0x8200 - 0x82FF : Graphical LCD (ST7920)
0xA000 - 0xBFFF : UART (MC68B50)
0xC000 - 0xFFFF : ROM (16k)
```

## Graphical LCD

It's a 128x64 LCD, with a ST7920 controller. Due to a hardware bug (either my address decode logic is too slow, or I'm just clocking it too fast, or something else), I can't read the "busy" status flag (it's always asserted), so all operations have to be done via timing rather than polling.
