      title   FIND Messages


CR      equ     0dh                     ;A Carriage Return
LF      equ     0ah                     ;A Line Feed

code    segment public

        PUBLIC  bad_vers,crlf,errmsg1,errlen1,errmsg2,errlen2
        PUBLIC  errmsg3_pre,errlen3_pre,errmsg4_pre,errlen4_pre
        PUBLIC  errmsg3_post,errlen3_post,errmsg4_post,errlen4_post
        PUBLIC  errmsg5,errlen5,errmsg5_opt
        PUBLIC  heading,heading_len

bad_vers db     "このDOSのバージョンでは実行できません$"
crlf     db      CR,LF

errmsg1 db      "FIND: パラメータの数が不正です",CR,LF
errlen1 db      $ - errmsg1

errmsg2 db      "FIND: 文法エラー",CR,LF
errlen2 db      $ - errmsg2

;"errmsg3_pre<name of file>errmsg3_post"
errmsg3_pre     db      "FIND: ファイルが見つかりません"
errlen3_pre     db      $ - errmsg3_pre
errmsg3_post    db      CR,LF
errlen3_post    db      $ - errmsg3_post

;"errmsg4_pre<name of file>errmsg4_post"
errmsg4_pre     db      "FIND: 読取りエラー : "
errlen4_pre     db      $ - errmsg4_pre
errmsg4_post    db      CR,LF
errlen4_post    db      $ - errmsg4_post

errmsg5         db      "FIND: 不正なパラメータ : "
errmsg5_opt     db      ?
errlen5         db      $ - errmsg5

heading db      CR,LF,"---------- "
heading_len db  $ - heading

code    ends
        end
                                                                                            