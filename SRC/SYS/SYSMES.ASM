   TITLE Message file for MS-DOS SYS Program

FALSE   EQU     0
TRUE    EQU     NOT FALSE

        INCLUDE DOSSYM.ASM

Message MACRO   label,text
        PUBLIC  label,label&Len
label       DB  text
label&Len   DW  $-label
ENDM


IBMJAPVER EQU   FALSE

CONST   SEGMENT PUBLIC BYTE

; only this message must be terminated with a $
        PUBLIC  BadVer
BADVER  DB      "このDOSのバージョンでは実行できません",13,10,"$"

        IF      IBMJAPVER
        Message BadDisk,<"このディスクは起動できません">
        ENDIF

        Message BadDrv,<"無効なドライブ指定です">
        Message BadParm,<"無効なパラメータです">
        Message NoDest,<"システム領域のための空きがありません">
        Message BadSiz,<"システムのサイズが合いません">
        Message Done,<"システムが転送されました">

        PUBLIC  GetSys,SysDrv,GetSysLen
GETSYS      DB      "システムディスクをドライブ "
SYSDRV      DB      "A に差し込み",13,10
            DB      "どれかキーを押してください",13,10
GetSysLen   DW  GetSysLen-GetSys

CONST   ENDS

DATA    SEGMENT BYTE PUBLIC
DATA    ENDS

CODE    SEGMENT
DG      GROUP   CODE,CONST,DATA
        ASSUME  CS:DG,DS:DG,ES:DG,SS:DG

CODE    ENDS
        END
