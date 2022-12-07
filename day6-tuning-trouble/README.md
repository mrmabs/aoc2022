# Day 6 - Turing Trouble

## In x86-64 assembler!

I ran into some interesting issues with writing this one in assembler, I was able to switch into assembler thinking mode easy enough, but when I was writing 8086 assembler while I was a teenager, I didn't do many functions and loops. I fell into a lot of issues a few times until I took a step back, and rethought the problem out in assembler, rather than trying to apply techniques from high level interpretive languages that I have become accustom too. 

At one stage I was putting out my hair when some code that roughly looked like this:

```
mov r8b, 0
mov r9b, 0
cmp r8b, r9b
je next
```

Didn't jump. Fun times.

## Personal history

The first time I really gave assembly a go was on an XT I was gifted many years after it had gone out of date. I decided to write an EMS emmulator as a DOS TSR. The code has been long lost now, but it was fun hooking interrupts and using a hard drive as a type of swap space, for the few applications that would actually use it.

## Running

You need to adjust the `size` variable at the top for the match size, for this challenge, 4 or 14. I have also included how I tested today's code, simply echoing the line.

$ `nasm -f elf64 day6.asm`

$ `ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o day6 -lc day6.o`

$ `echo "mjqjpqmgbljsphdztnvjfqwrcgsmlb" | ./day6`

or

$ `cat day6-input.txt | ./day6`
