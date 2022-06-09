SYSINITSEG      SEGMENT PUBLIC BYTE 'SYSTEM_INIT'

        PUBLIC  BADOPM,CRLFM,BADSIZ_PRE,BADLD_PRE,BADCOM,SYSSIZE
        PUBLIC  BADSIZ_POST,BADLD_POST,BADCOUNTRY

BADOPM  DB      13,10,"CONFIG.SYS に無効なコマンドかパラメータがあります"
BADSIZ_PRE   LABEL   BYTE
BADLD_PRE   LABEL   BYTE
CRLFM   DB      13,10,'$'

BADSIZ_POST  DB      13,10,"デバイスドライバで指定されたセクタサイズは大きすぎます"

BADLD_POST   DB      13,10," が無効または見つかりません"

BADCOM  DB      "コマンドインタプリンタ",0

BADCOUNTRY DB   "無効なカントリーコードです",13,10,'$'

SYSSIZE LABEL   BYTE

SYSINITSEG      ENDS
        END
                                                                                                
        