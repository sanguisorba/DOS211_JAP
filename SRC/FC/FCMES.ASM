        title   File Compare Routine for MSDOS 2.0

CR      equ     0dh
LF      equ     0ah

FALSE   equ     0
TRUE    equ     0ffh


const   segment public byte

        PUBLIC  vers_err,opt_err,opt_e,crlf,opt_err_len
        PUBLIC  found_err_pre,found_err_pre_len,found_err_post
        PUBLIC  found_err_post_len,read_err_pre,read_err_pre_len
        PUBLIC  read_err_post,read_err_post_len,file_err,file_err_len
        PUBLIC  bf1ne,bf1ne_len,bf2ne,bf2ne_len,bhead,bhead_len
        PUBLIC  int_err,int_err_len,dif_err,dif_err_len,diff_sep,diff_sep_len
        PUBLIC  args_err,args_err_len,fname_sep,fname_sep_len

vers_err db     "このDOSのバージョンでは実行できません$"

opt_err db      "無効なパラメータです"
opt_e   db      0
crlf    db      CR,LF
opt_err_len db  $ - opt_err

;"found_err_pre<name of file>found_err_post"
found_err_pre      db     "ファイルが見つかりません : "
found_err_pre_len  db     $ - found_err_pre
found_err_post     label  byte
found_err_post_len db     $ - found_err_post

;"read_err_pre<name of file>read_err_post"
read_err_pre       db     "読取りエラー : "
read_err_pre_len   db     $ - read_err_pre
read_err_post      label  byte
read_err_post_len  db     $ - read_err_post

file_err db     "不良ファイルです"
file_err_len db  $ - file_err

int_err db      "システムエラーです"
int_err_len db   $ - int_err

dif_err db      "ファイルが異なります"
dif_err_len db   $ - dif_err

args_err db     "パラメータの数が不正です"
args_err_len db  $ - args_err

fname_sep db    CR,LF,"----------"
fname_sep_len db  $ - fname_sep

diff_sep db     CR,LF,"-----------------------------------------------",CR,LF
diff_sep_len db  $ - diff_sep

bf1ne   db      CR,LF,"F1 にデータが残っています",CR,LF
bf1ne_len db    $ - bf1ne

bf2ne   db      CR,LF,"F2 にデータが残っています",CR,LF
bf2ne_len db    $ - bf2ne

bhead   db      CR,LF,'--ADDRS----F1---F2-',CR,LF
bhead_len db    $ - bhead

const   ends
        end
