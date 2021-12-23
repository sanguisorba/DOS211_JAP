# Disassembled STDIO (IO - STRIN - IO2)

Since the rebuilded MSDOS.SYS didn't work well in Japanese environment, I disassembled original one and reconstructed.

There were other changes in the original MSDOS.SYS, but I will NOT upload them because they are not related to Japanese environment.

IO.ASM and IO2.ASM are based on the work of John Elliott. (see README.TXT)

# IO
* Delete the function table.
* Add "OUTCARPO" entry which is called from STRIN.

# STRIN
* Most of the "added" code was the exception handlings for KANJI, which calls the TESTKANJ method (written in FCB.ASM).

# IO2
No changes.
