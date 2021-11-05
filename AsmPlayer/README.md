# Assembly Players

This directory contains assembly players for the ZX Spectrum, Amstrad CPC and MSX. The top level assembly files are named wyzproplay_*sys*.asm where *sys* is one of the following:

* zx
* cpc
* msx

The top level assembly files include the shared common code (*wyzproplayer47c_common.inc*), the RAM variables (*wyzproplay_ram.inc*), the song table (*wyzsongtable.inc*), and the system specific code to access the PSG registers.

*wyzsongtable.inc* defines a table of songs and includes the files exported from WYZTracker 2.0, *.mus and *.mus.asm

The following functions may be exported from the top level assembly files, uncomment if required.

* wyz_player_init
* wyz_player_stop
* wyz_play_frame
* wyz_play_song
* wyz_play_sound
* wyz_play_fx

## wyz_player_init

Should be called once to initialize the player. If *wyz_play_frame* is being called from an ISR this call must be made before interrupts are initialized.

## wyz_player_stop

Stop all output and reset the player.

## wyz_play_frame

Should be called every 1/50th of a second, e.g. from an ISR to play the next frame of the audio.

## wyz_play_song

Called to start playing a song. The 'A' register should contain the index of the song in the song table to be played.

## wyz_play_sound

Called to play a sound. The 'A' register should contain the index of the sound to play and the 'B' register contains the audio channel to use.

## wyz_play_fx

Called to plan an FX. The 'A' register should contain the index of the FX to play and the 'B' register contains the audio channel to use.
