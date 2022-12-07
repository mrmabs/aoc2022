# Day 6 - Turing Trouble

Today, in x86-64 assembler!

I ran into some interesting issues with writing this one in assembler, I was able to switch into assembler thinking mode easy enough, but when I was writing 8086 assembler while I was a teenager, I didn't do many functions and loops. I fell on my face a few times until I rethought the problem out in assembler, rather than trying to apply techniques from high level interpretive languagaes that I have become accustom too. 

At one stage I was putting out my hair when some code that roughly looked like this:
```
mov r8b, 0
mov r9b, 0
cmp r8b, r9b
je next
```
Didn't jump.

$ `nasm -f elf64 day6.asm`

$ `ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o day6 -lc day6.o`

$ `echo "mjqjpqmgbljsphdztnvjfqwrcgsmlb" | ./day6`

or

$ `cat day6-input.txt | ./day6`
