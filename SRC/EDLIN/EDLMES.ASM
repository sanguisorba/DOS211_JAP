        title   EDLIN Messages

;-----------------------------------------------------------------------;
;                                                                       ;
;       Done for Vers 2.00 (rev 9) by Aaron Reynolds                    ;
;       Update for rev. 11 by M.A. Ulloa                                ;
;                                                                       ;
;-----------------------------------------------------------------------;

FALSE   EQU     0
TRUE    EQU     NOT FALSE


        .xlist
        INCLUDE DOSSYM.ASM
        .list


CODE    SEGMENT PUBLIC BYTE
CODE    ENDS

CONST   SEGMENT PUBLIC BYTE
CONST   ENDS

DATA    SEGMENT PUBLIC BYTE
        EXTRN   QFLG:BYTE,FCB2:BYTE
DATA    ENDS

DG      GROUP   CODE,CONST,DATA

CODE SEGMENT PUBLIC BYTE

ASSUME  CS:DG,DS:DG,SS:DG,ES:DG

        PUBLIC  QUIT,QUERY
        EXTRN   rest_dir:NEAR,CRLF:NEAR

QUIT:
        MOV     DX,OFFSET DG:QMES
        MOV     AH,STD_CON_STRING_OUTPUT
        INT     21H
        MOV     AX,(STD_CON_INPUT_FLUSH SHL 8) OR STD_CON_INPUT
        INT     21H              ;Really quit?
        AND     AL,5FH
        CMP     AL,"Y"
        JZ      NOCRLF
        JMP     CRLF
NOCRLF:
        MOV     DX,OFFSET DG:FCB2
        MOV     AH,FCB_CLOSE
        INT     21H
        MOV     AH,FCB_DELETE
        INT     21H
        call    rest_dir                ;restore directory if needed
        INT     20H

QUERY:
        TEST    BYTE PTR [QFLG],-1
        JZ      RET9
        MOV     DX,OFFSET DG:ASK
        MOV     AH,STD_CON_STRING_OUTPUT
        INT     21H
        MOV     AX,(STD_CON_INPUT_FLUSH SHL 8) OR STD_CON_INPUT
        INT     21H
        PUSH    AX
        CALL    CRLF
        POP     AX
        CMP     AL,13           ;Carriage return means yes
        JZ      RET9
        CMP     AL,"Y"
        JZ      RET9
        CMP     AL,"y"
RET9:   RET

CODE    ENDS

CONST   SEGMENT PUBLIC BYTE

        PUBLIC  BADDRV,NDNAME,bad_vers_err,opt_err,NOBAK
        PUBLIC  NODIR,DSKFUL,MEMFUL,FILENM,BADCOM,NEWFIL
        PUBLIC  NOSUCH,TOOLNG,EOF,DEST,MRGERR,ro_err,bcreat

BADDRV  DB      "ドライブまたはファイル名の指定が違います$"
NDNAME  DB      "ファイル名を指定してください$"

bad_vers_err db "このDOSのバージョンでは実行できません$"
opt_err db      "無効なパラメータです$"
ro_err  db      "このファイルは読取り専用です",13,10,"$"
bcreat  db      "ファイル作成ができませんでした",13,10,"$"

NOBAK   DB      ".BAK ファイルは編集できません--ファイル名を変えてください$"
NODIR   DB      "このディレクトリにこれ以上のファイルは追加できません$"
DSKFUL  DB      "ディスク容量不足のため書込みは完了しませんでした$"
MEMFUL  DB      13,10,"メモリ不足です",13,10,"$"
FILENM  DB      "ファイルが見つかりませんでした",13,10,"$"
BADCOM  DB      "入力エラーです",13,10,"$"
NEWFIL  DB      "新しいファイルです",13,10,"$"
NOSUCH  DB      "見つかりませんでした",13,10,"$"
ASK     DB      "よろしいですか (Y/N)? $"
TOOLNG  DB      "一行が長すぎます",13,10,"$"
EOF     DB      "ファイルの終端です",13,10,"$"
QMES    DB      "編集を中止しますか (Y/N)? $"
DEST    DB      "転送先の行番号を指定してください",13,10,"$"
MRGERR  DB      "メモリ不足のためファイルが読み込めません",13,10,"$"

CONST   ENDS
        END
                        