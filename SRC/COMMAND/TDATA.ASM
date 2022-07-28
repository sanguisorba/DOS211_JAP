TITLE   COMMAND Transient Initialized DATA

        INCLUDE COMSW.ASM
.xlist
.xcref
        INCLUDE COMSEG.ASM
.list
.cref

        INCLUDE IFEQU.ASM

TRANCODE        SEGMENT PUBLIC
        EXTRN   PRINT_DATE:NEAR,PRINT_TIME:NEAR,PRINT_DEFAULT_DIRECTORY:NEAR
        EXTRN   PRINT_DRIVE:NEAR,PRINT_VERSION:NEAR,PRINT_G:NEAR
        EXTRN   PRINT_L:NEAR,PRINT_B:NEAR,CRLF2:NEAR,OUT:NEAR,PRINT_ESC:NEAR
        EXTRN   PRINT_BACK:NEAR,PRINT_EQ:NEAR

        EXTRN   IFNOT:NEAR,IFERLEV:NEAR,IFEXISTS:NEAR

        EXTRN   CATALOG:NEAR,CRENAME:NEAR,ERASE:NEAR,TYPEFIL:NEAR
        EXTRN   TCOMMAND:NEAR,COPY:NEAR,PAUSE:NEAR,DATE:NEAR,CTIME:NEAR
        EXTRN   VERSION:NEAR,VOLUME:NEAR,$CHDIR:NEAR,$MKDIR:NEAR,$RMDIR:NEAR
        EXTRN   CNTRLC:NEAR,VERIFY:NEAR,ADD_NAME_TO_ENVIRONMENT:NEAR
        EXTRN   ADD_PROMPT:NEAR,PATH:NEAR,$EXIT:NEAR,CTTY:NEAR,ECHO:NEAR
        EXTRN   GOTO:NEAR,SHIFT:NEAR,$IF:NEAR,$FOR:NEAR,CLS:NEAR
TRANCODE        ENDS

; Data for transient portion

TRANDATA        SEGMENT PUBLIC BYTE

        PUBLIC  BADBAT,NEEDBAT,BADNAM,RENERR,NOTFND,NOSPACE,ENVERR,FULDIR
        PUBLIC  OVERWR,LOSTERR,DIRMES_PRE,DIRMES_POST,BADDRV,PAUSEMES,BADSWT
        PUBLIC  COPIED_PRE,COPIED_POST,BYTMES_PRE,BYTMES_POST
        PUBLIC  WEEKTAB,BADDAT,NEWDAT,BADTIM,NEWTIM,SUREMES,CURDAT_MID
        PUBLIC  CURDAT_PRE,CURDAT_POST,CURTIM_PRE,CURTIM_POST,VERMES_POST
        PUBLIC  DMES,VERMES_PRE,VOLMES,GOTVOL,NOVOL,BADCD,BADMKD,BADRMD
        PUBLIC  BAD_ON_OFF,NULPATH,PATH_TEXT,PROMPT_TEXT,BADPMES
        PUBLIC  BADDEV,BADLAB,SYNTMES,FORNESTMES,PIPEEMES,INBDEV,OFFMES
        PUBLIC  ONMES,CTRLCMES,VERIMES,ECHOMES,BADCPMES,BADARGS,DEVWMES
        PUBLIC  ACRLF,DBACK,CLSSTRING,PROMPT_TABLE,IFTAB,COMTAB
        PUBLIC  TRANDATAEND,DIRHEAD_PRE,DIRHEAD_POST

        ORG     0
ZERO    =       $
BADBAT  DB      13,10,"バッチファイルが見つかりません",13,10,"$"
NEEDBAT DB      13,10,"バッチファイルのあるディスクを差し込み"
        DB      13,10,"どれかキーを押してください",13,10,"$"
BADNAM  DB      "コマンドまたはファイル名が違います",13,10,"$"
RENERR  DB      "重複したファイル名か　あるいは"
NOTFND  DB      "ファイルが見つかりません",13,10,"$"
NOSPACE DB      "ディスク容量がいっぱいです",13,10,"$"
ENVERR  DB      "メモリ不足のため環境が構築できません",13,10,"$"
FULDIR  DB      "ディレクトリがいっぱいです",13,10,"$"
OVERWR  DB      "自分自身へコピーすることはできません",13,10,"$"
LOSTERR DB      "コピー先の内容がコピー前に失われました",13,10,"$"

;"COPIED_PRE<# files copied>COPIED_POST"
COPIED_POST  DB      " 個のファイルをコピーしました",13,10
COPIED_PRE   DB      "$"

;"DIRMES_PRE<# files in dir>DIRMES_POST"
DIRMES_POST  DB      " 個のファイルがあります",13,10
DIRMES_PRE   DB      "$"

;"BYTMES_PRE<# free bytes>BYTMES_POST"
BYTMES_POST  DB      " バイトが使用可能です",13,10
BYTMES_PRE   DB      "$"

BADDRV  DB      "無効なドライブ指定です",13,10,"$"
PAUSEMES DB      "準備ができたらどれかキーを押してください . . . $"
BADSWT  DB      "無効なパラメータです",13,10,"$"
WEEKTAB DB      "(日)(月)(火)(水)(木)(金)(土)"
BADDAT  DB      13,10,"無効な日付です$"

;"CURDAT_PRE<day of week>CURDAT_MID<MO,DAY,YR>CURDAT_POST"
;Note: CURDAT_MID also appears in the date printed via PROMPT command
CURDAT_PRE   DB      "現在の日付 : "
CURDAT_MID   LABEL   BYTE
CURDAT_POST  DB      "$"

NEWDAT  DB      13,10,"新しい日付を入力してください : $"
BADTIM  DB      13,10,"無効な時刻です$"

;"CURTIM_PRE<HR,MIN,SEC,HSEC>CURTIM_POST"
CURTIM_PRE   DB      "現在の時刻 : "
CURTIM_POST  DB      "$"

NEWTIM  DB      13,10,"新しい時刻を入力してください : $"
SUREMES DB      "よろしいですか (Y/N)? $"
DMES    DB      " <DIR>   $"

;"VERMES_PRE<version #>VERMES_POST"
        IF      IBMVER
VERMES_PRE  DB      "TeleVideo Personal Computer DOS Version "
        ENDIF
        IF      MSVER
VERMES_PRE  DB      "MS-DOS ﾊﾞｰｼﾞｮﾝ"
        ENDIF
VERMES_POST DB      "$"

VOLMES  DB      " ドライブ $"
GOTVOL  DB      " のボリュームラベルは $"
NOVOL   DB      " にはボリュームラベルがありません$"

BADCD   DB      "無効なディレクトリです",13,10,"$"
BADMKD  DB      "ディレクトリが作れません",13,10,"$"
BADRMD  DB      "無効なパスか、ディレクトリでないか、",13,10
        DB      "ディレクトリが空ではありません",13,10,"$"
BAD_ON_OFF DB   "ON か OFFを指定してください"        ;Note Run over to next message

;"DIRHEAD_PRE<path of dir>DIRHEAD_POST"
DIRHEAD_POST DB      13,10,"$"
DIRHEAD_PRE  DB      " ディレクトリは $"

NULPATH DB      "パスが未定義です $"
PATH_TEXT    DB "PATH="
PROMPT_TEXT  DB "PROMPT="
BADPMES DB      "無効なパスです",13,10,"$"
BADDEV  DB      "無効なデバイスです",13,10,"$"
BADLAB  DB      "ラベルが見つかりません",13,10,"$"
SYNTMES DB      "文法エラー",13,10,"$"
FORNESTMES DB   13,"FOR は入れ子にできません",13,10,"$"
PIPEEMES DB     "パイプ用の中間ファイルが作れません",13,10,"$"
INBDEV  DB      "そのデバイスからバイナリは読み取れません",13,10,"$"
OFFMES  DB      "OFF",13,10,"$"
ONMES   DB      "ON",13,10,"$"
CTRLCMES DB     "BREAK は $"
VERIMES DB      "VERIFY は $"
ECHOMES DB      "ECHO は $"
BADCPMES DB     "無効なパスまたはファイル名です",13,10,"$"
BADARGS DB      "パラメータの数が不正です",13,10,"$"
DEVWMES DB      "デバイスへの書込み中にエラーがありました"
ACRLF   DB      13,10,"$"
DBACK   DB      8," ",8,0               ; DESTRUCTIVE BACK SPACE

CLSSTRING DB    4,01BH,"[2J"            ; ANSI Clear screen

PROMPT_TABLE LABEL BYTE
        DB      "D"
        DW      OFFSET TRANGROUP:PRINT_DATE
        DB      "T"
        DW      OFFSET TRANGROUP:PRINT_TIME
        DB      "P"
        DW      OFFSET TRANGROUP:PRINT_DEFAULT_DIRECTORY
        DB      "N"
        DW      OFFSET TRANGROUP:PRINT_DRIVE
        DB      "V"
        DW      OFFSET TRANGROUP:PRINT_VERSION
        DB      "G"
        DW      OFFSET TRANGROUP:PRINT_G
        DB      "L"
        DW      OFFSET TRANGROUP:PRINT_L
        DB      "B"
        DW      OFFSET TRANGROUP:PRINT_B
        DB      "_"
        DW      OFFSET TRANGROUP:CRLF2
        DB      "$"
        DW      OFFSET TRANGROUP:OUT
        DB      "E"
        DW      OFFSET TRANGROUP:PRINT_ESC
        DB      "H"
        DW      OFFSET TRANGROUP:PRINT_BACK
        DB      "Q"
        DW      OFFSET TRANGROUP:PRINT_EQ
        DB      0                       ; NUL TERMINATED

IFTAB   LABEL   BYTE                    ; Table of IF conditionals
        DB      3,"NOT"                 ; First byte is count
        DW      OFFSET TRANGROUP:IFNOT
        DB      10,"ERRORLEVEL"
        DW      OFFSET TRANGROUP:IFERLEV
        DB      5,"EXIST"
        DW      OFFSET TRANGROUP:IFEXISTS
        DB      0

COMTAB  DB      4,"DIR",1               ; Table for internal command names
        DW      OFFSET TRANGROUP:CATALOG
        DB      7,"RENAME",1
        DW      OFFSET TRANGROUP:CRENAME
        DB      4,"REN",1
        DW      OFFSET TRANGROUP:CRENAME
        DB      6,"ERASE",1
        DW      OFFSET TRANGROUP:ERASE
        DB      4,"DEL",1
        DW      OFFSET TRANGROUP:ERASE
        DB      5,"TYPE",1
        DW      OFFSET TRANGROUP:TYPEFIL
        DB      4,"REM",0
        DW      OFFSET TRANGROUP:TCOMMAND
        DB      5,"COPY",1
        DW      OFFSET TRANGROUP:COPY
        DB      6,"PAUSE",0
        DW      OFFSET TRANGROUP:PAUSE
        DB      5,"DATE",0
        DW      OFFSET TRANGROUP:DATE
        DB      5,"TIME",0
        DW      OFFSET TRANGROUP:CTIME
        DB      4,"VER",0
        DW      OFFSET TRANGROUP:VERSION
        DB      4,"VOL",1
        DW      OFFSET TRANGROUP:VOLUME
        DB      3,"CD",1
        DW      OFFSET TRANGROUP:$CHDIR
        DB      6,"CHDIR",1
        DW      OFFSET TRANGROUP:$CHDIR
        DB      3,"MD",1
        DW      OFFSET TRANGROUP:$MKDIR
        DB      6,"MKDIR",1
        DW      OFFSET TRANGROUP:$MKDIR
        DB      3,"RD",1
        DW      OFFSET TRANGROUP:$RMDIR
        DB      6,"RMDIR",1
        DW      OFFSET TRANGROUP:$RMDIR
        DB      6,"BREAK",0
        DW      OFFSET TRANGROUP:CNTRLC
        DB      7,"VERIFY",0
        DW      OFFSET TRANGROUP:VERIFY
        DB      4,"SET",0
        DW      OFFSET TRANGROUP:ADD_NAME_TO_ENVIRONMENT
        DB      7,"PROMPT",0
        DW      OFFSET TRANGROUP:ADD_PROMPT
        DB      5,"PATH",0
        DW      OFFSET TRANGROUP:PATH
        DB      5,"EXIT",0
        DW      OFFSET TRANGROUP:$EXIT
        DB      5,"CTTY",1
        DW      OFFSET TRANGROUP:CTTY
        DB      5,"ECHO",0
        DW      OFFSET TRANGROUP:ECHO
        DB      5,"GOTO",0
        DW      OFFSET TRANGROUP:GOTO
        DB      6,"SHIFT",0
        DW      OFFSET TRANGROUP:SHIFT
        DB      3,"IF",0
        DW      OFFSET TRANGROUP:$IF
        DB      4,"FOR",0
        DW      OFFSET TRANGROUP:$FOR
        DB      4,"CLS",0
        DW      OFFSET TRANGROUP:CLS
        DB      0               ; Terminate command table

TRANDATAEND     LABEL   BYTE

TRANDATA        ENDS
        END
