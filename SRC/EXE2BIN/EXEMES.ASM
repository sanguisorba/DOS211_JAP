        title   LOCATE (EXE2BIN) Messages

FALSE   EQU     0
TRUE    EQU     NOT FALSE

DATA    SEGMENT PUBLIC BYTE

        PUBLIC  bad_vers_err,NOTFND,NOROOM,DIRFULL,FULL,PROMPT,CRLF
        PUBLIC  CANTFIX,RDBAD

bad_vers_err db "このDOSのバージョンでは実行できません$"
NOTFND  DB      "ファイルが見つかりません$"
NOROOM  DB      "メモリ不足です$"
DIRFULL DB      "このディレクトリにこれ以上のファイルは追加できません$"
FULL    DB      "ディスク容量不足です$"
PROMPT  DB      "セグメントを指定してください (HEX): $"
CRLF    DB      13,10,"$"
CANTFIX DB      "このファイルは変換できません$"
RDBAD   DB      "警告 - EXE ファイルのヘッダ情報と"
        DB      13,10,"          ファイルサイズが一致しません",13,10,"$"


DATA    ENDS
        END
                                            