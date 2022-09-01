        public  _music

        extern  wyz_player_init
        extern  wyz_play_song
        extern  wyz_play_frame
_music:
        call    wyz_player_init

        xor     a
        call    wyz_play_song
loop:
        halt
  IFDEF CPC
        halt
        halt
        halt
        halt
        halt
  ENDIF
        call    wyz_play_frame
        jp      loop

