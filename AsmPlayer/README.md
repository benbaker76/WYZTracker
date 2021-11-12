# Assembly Players

This directory contains assembly players for the ZX Spectrum, Amstrad CPC and MSX. The top level assembly files are named wyzproplay_*sys*.asm where *sys* is one of the following:

* zx
* cpc
* msx

The top level assembly files include the shared common code (*wyzproplayer47c_common.inc*), the RAM variables (*wyzproplay_ram.inc*), the song table (*wyzsongtable.inc*), and the system specific code to access the PSG registers.

## Application Programming Interface

The following functions are exported from the top level assembly files.

* wyz_player_init
* wyz_player_stop
* wyz_play_frame
* wyz_play_song
* wyz_play_sound
* wyz_play_fx

### wyz_player_init

Should be called once to initialize the player. If *wyz_play_frame* is being called from an ISR this call must be made before interrupts are initialized.

### wyz_player_stop

Stop all output and reset the player.

### wyz_play_frame

Should be called every 1/50th of a second, e.g. from an ISR to play the next frame of the audio. If this routine is called from an ISR, all the other API's should be called with interrupts disabled to prevent race conditions when accessing the global RAM variables.

### wyz_play_song

Called to start playing a song. The 'A' register should contain the index of the song in the song table to be played.

### wyz_play_sound

Called to play a sound. The 'A' register should contain the index of the sound to play and the 'B' register contains the audio channel to use.

### wyz_play_fx

Called to plan an FX. The 'A' register should contain the index of the FX to play and the 'B' register contains the audio channel to use.

## Demonstration

*demo.asm* is a simple assembly program to demonstrate the API usage. To build the demo you must have z88dk installed. Type ```make``` in the AsmPlayer directory to build the images for the Amstrad CPC, ZX Spectrum and MSX.

### Demonstration Images

* msx.img - MSX disk image
* cpc.dsk - Amstrad CPC disk image
* zx.tap - ZX Spectrum tape image

## Usage Model

The [Programmable Sound Generator](https://en.wikipedia.org/wiki/General_Instrument_AY-3-8910) (PSG) has 3 tone channels (A, B, C) and a noise generator which may be output to any (or all) of the tone channels via the mixer. The 3 tone channels map to channels 0-2 and the noise generator maps to the FX channel in WYZTracker. WYZTracker allows the FX channel to be output to any one of the PSG tone channels.

If a song is played using the *wyz_play_song* API, the specified PSG channels will be utilized. If the song includes an FX track, it will be output using the *wyz_play_fx* API to the channel specified in WYZTracker. While a song is actively using the FX track, the *wyz_play_fx* API should not be used.

Playing other sounds while a song is playing is possible, even if the FX track is being utilized, by using the *wyz_play_sound* API. Try to pick a lightly used PSG tone channel to minimize the interruption to the song.

## .MUS File Format (work in progress)

|Byte#| Description            |
|-----|------------------------|
| 0   | Tempo                  |
| 1   | Header: <br>Bit<br>0 = Loop<br>3-1 = FX Channel<br>6-4 = Channels |
|2-3  | Reserved               |
|4-5  | Loop offset, channel A |
|6-7  | Loop offset, channel B |
|8-9  | Loop offset, channel C |
|10-11| Loop offset, channel P |
|12.. | Channel A data         |
| ..  | Channel B data         |
| ..  | Channel C data         |
| ..  | Channel P data         |

### Channel Data

Bits

* 7-6 Length - Encoded as 2^(Length+1)
* 5-0 Action
  * 000000b (0x00) - End of channel data (length is also 00b)
  * 000001b (0x01) - Silence
  * 111110b (0x3e) - Punctillo?
  * 111111b (0x3f) - Command (Length determines the bytes to follow)
    * Length = 0 - 2 Bytes &lt;Instrument&gt; &lt;tempo modifier + volume modifier&gt;
    * Length = 1 - 1 Byte &lt;Effect length and code&gt;
      * Bits 7-6 Length, Encoded as 2^(Length+1)
      * Bits 5-0 Code
    * Length = 2 - 1 Byte &lt;Envelope&gt;
