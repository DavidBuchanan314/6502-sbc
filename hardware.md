## Memory map:
```
0x0000 - 0x7FFF : RAM (32k)
0x8200 - 0x82FF : Graphical LCD (ST7920)
0xA000 - 0xBFFF : UART (MC68B50)
0xC000 - 0xFFFF : ROM (16k)
```

## UART

It's a MC68B50. It supports divide-by-1, 16 and 64 modes. Since the system clock is 4MHz, /1 is too fast, but /16 works fine giving 250000 baud. This is a non-standard frequency, but most USB TTL uart adapters support it just fine (notably, the one I soldered to the board), especially since it evenly divides the 12MHz USB clock.

## Graphical LCD

It's a 128x64 LCD, with a ST7920 controller. Due to a hardware bug (either my address decode logic is too slow, or I'm just clocking it too fast, or something else), I can't read the "busy" status flag (it's always asserted), so all operations have to be done via timing rather than polling.
