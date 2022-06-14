;       Exported routines
        public  wyz_play_frame
        public  wyz_play_song
        public  wyz_play_fx
        public  wyz_play_sound
        public  wyz_player_init
        public  wyz_player_stop

        DEFINE  NMOS_Z80

        include "wyzproplay47c_common.inc"

ROUT:   LD      A, (PSG_REG+13)
        AND     A
        JR      Z, NO_BACKUP_ENVOLVENTE
        LD      (ENVOLVENTE_BACK), A
        XOR     A
NO_BACKUP_ENVOLVENTE:
        LD      HL, PSG_REG_SEC
LOUT:
        CALL    WRITEPSGHL
        INC     A
        CP      13
        JR      NZ, LOUT
        LD      A, (HL)
        AND     A
        RET     Z
        LD      A, 13
        CALL    WRITEPSGHL
        XOR     A
        LD      (PSG_REG+13), A
        LD      (PSG_REG_SEC+13), A
        RET

;; A = REGISTER
;; (HL) = VALUE
WRITEPSGHL:
        LD      B, $F4
        OUT     (C), A
        LD      BC, $F6C0
        OUT     (C), C
  IFDEF NMOS_Z80
        DB      $ED                     ; Undocumented op-code out(c), 0 only on NMOS CPU's
        DB      $71
  ELSE
        LD      E, 0
        OUT     (C), E
  ENDIF
        LD      B, $F5
        OUTI
        LD      BC, $F680
        OUT     (C), C
  IFDEF NMOS_Z80
        DB      $ED                     ; Undocumented op-code out(c), 0 only on NMOS CPU's
        DB      $71
  ELSE
        OUT     (C), E
  ENDIF
        RET

        ;
        ; Song table setup
        ;
        include "wyzsongtable.inc"

        ;
        ; RAM variables
        ;
        include "wyzproplay_ram.inc"
