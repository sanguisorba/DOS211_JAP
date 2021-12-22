TITLE FORMAT Messages

FALSE   EQU     0
TRUE    EQU     NOT FALSE

IBMVER  EQU     FALSE

.xlist
.xcref
        INCLUDE DOSSYM.ASM
.cref
.list

CODE    SEGMENT PUBLIC 'CODE'
        ASSUME  CS:CODE,DS:CODE,ES:CODE

        PUBLIC  BADVER,SNGMSG,SNGDRV,HRDMSG,HRDDRV,REPORT
        PUBLIC  LABPRMT,TARGMSG,TARGDRV
        PUBLIC  SYSTRAN,CRLFMSG,INVCHR,INVDRV,INVPAR
        PUBLIC  SYSMSG,SYSDRV,FRMTERR,NOTSYS,NOUSE,MEMEX
        PUBLIC  WAITYN
        EXTRN   PRINT:NEAR,CRLF:NEAR,UNSCALE:NEAR,DISP32BITS:NEAR
        EXTRN   FDSKSIZ:DWORD,SECSIZ:WORD,CLUSSIZ:WORD,SYSSIZ:DWORD
        EXTRN   BADSIZ:DWORD

        ;Wait for "Y" or "N"
WAITYN:
        MOV     DX,OFFSET MORMSG        ;Point to the message
        CALL    PRINT                   ;And print it
        MOV     AX,(STD_CON_INPUT_FLUSH SHL 8) OR STD_CON_INPUT
                                        ;Flush buffer and wait for keystroke
        INT     21H                     ;Input character now a Y or N
        CMP     AL,81H
        JB      NOK
        CMP     AL,0A0H
        JB      ISK
        CMP     AL,0E0H
        JB      NOK
        CMP     AL,0FDH
        JB      ISK
ISK:
        MOV     AH,STD_CON_INPUT
        INT     21H
        JMP     WAITYN
NOK:
        AND     AL,0DFH                 ;So lower case works too
        CMP     AL,"Y"
        JZ      WAIT20
        CMP     AL,"N"
        JZ      WAIT10
        CALL    CRLF
        JMP     SHORT WAITYN
WAIT10: STC
WAIT20: RET


;*********************************************
; Make a status report including the following information:
; Total disk capacity
; Total system area used
; Total bad space allocated
; Total data space available
;NOTE:
;       The DISP32BITS routine prints the number in DI:SI followed
;          by the message pointed to by BX. If it is desired to print
;          a message before the number, point at the message with DX
;          and call PRINT.

REPORT:
        MOV     AX,WORD PTR FDSKSIZ
        MUL     SECSIZ
        MOV     CX,CLUSSIZ
        CALL    UNSCALE
        MOV     WORD PTR FDSKSIZ,AX
        MOV     WORD PTR FDSKSIZ+2,DX
        MOV     SI,AX
        MOV     DI,DX
        MOV     BX,OFFSET DSKSPC
        CALL    DISP32BITS              ;Report total disk space
        MOV     SI,WORD PTR SYSSIZ
        MOV     DI,WORD PTR SYSSIZ+2
        CMP     SI,0
        JNZ     SHOWSYS
        CMP     DI,0
        JZ      CHKBAD
SHOWSYS:
        MOV     BX,OFFSET SYSSPC
        CALL    DISP32BITS              ;Report space used by system
CHKBAD:
        MOV     SI,WORD PTR BADSIZ
        MOV     DI,WORD PTR BADSIZ+2
        CMP     SI,0
        JNZ     SHOWBAD
        CMP     DI,0
        JZ      SHOWDATA
SHOWBAD:
        MOV     BX,OFFSET BADSPC
        CALL    DISP32BITS              ;Report space used by bad sectors
SHOWDATA:
        MOV     CX,WORD PTR FDSKSIZ
        MOV     BX,WORD PTR FDSKSIZ+2
        SUB     CX,WORD PTR BADSIZ
        SBB     BX,WORD PTR BADSIZ+2
        SUB     CX,WORD PTR SYSSIZ
        SBB     BX,WORD PTR SYSSIZ+2
        MOV     SI,CX
        MOV     DI,BX
        MOV     BX,OFFSET DATASPC
        CALL    DISP32BITS              ;Report space left for user
        RET


BADVER  DB      "このDOSのバージョンでは実行できません",13,10,"$"
SNGMSG  DB      "新しいディスクをドライブ "
SNGDRV  DB      "x:　に差し込み",13,10,"どれかキーを押してください$"
HRDMSG  DB      "ドライブ "
HRDDRV  DB      "x: のフォーマットを開始します",13,10,"どれかキーを押してください$"
SYSTRAN DB      "システムが転送されました",13,10,"$"
MORMSG  DB      "もう一度フォーマットしますか (Y/N)?$"
CRLFMSG DB      13,10,"$"
INVCHR  DB      "ボリュームラベルで使用できない文字があります",13,10,"$"
INVDRV  DB      "無効なドライブ指定です$"
INVPAR  DB      "無効なパラメータです$"
TARGMSG DB      "もう一度ディスクをドライブ "
TARGDRV DB      "x:　に差し込み",13,10,"どれかキーを押してください$"
SYSMSG  DB      "DOS ディスクをドライブ "
SYSDRV  DB      "x:　に差し込み",13,10,"どれかキーを押してください$"
FRMTERR DB      "フォーマット失敗",13,10,13,10,"$"
NOTSYS  DB      "このディスクはシステムディスク未対応の規格です",13,10,"$"
NOUSE   DB      "トラック 0 が不良のため、このディスクは使用できません",13,10,"$"
MEMEX   DB      "システム転送のためのメモリが不足しています",13,10,"$"

;Report messages
DSKSPC  DB      " バイト : 全ディスク容量",13,10,"$"
SYSSPC  DB      " バイト : システム領域",13,10,"$"
BADSPC  DB      " バイト : 不良セクタ",13,10,"$"
DATASPC DB      " バイト : 使用可能ディスク容量",13,10,13,10,"$"

        IF      IBMVER
        PUBLIC  ASGERR
ASGERR  DB      "ASSIGNされたドライブはフォーマットできません$"
        ENDIF

LABPRMT DB      "ボリュームラベルを11バイト以内で入力してください",13,10
        DB      "英数字(半角)は1バイト,漢字(全角)は2バイト",13,10
        DB      "必要がなければ改行キー : $"

CODE    ENDS
        END
                                                                      

