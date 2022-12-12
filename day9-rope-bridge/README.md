# Day 8 Rope Bridge

## This one in, [Free]Pascal

Not quite catching up yet, but getting through. This one was interesting, working within the limitations of the FreePascal language. At one stage I had the code working for part one, but it didn't translate to part 2, so a rewrite was in order and I got it going for both.

Originally I had the tail follow the head by remembering the last position on the head, and moving the tail only if the head was too far away. Moving to part two the tail needed to change in relation to the section before it. I needed to rework the code to move each section; in this case I'm moving the section behind in up to two steps at a time.

## Personal History

I used Turbo Pascal for a bit of messing around in DOS in the mid-90's. I didn't use it as extensively as I did with with BASIC and x86 assembler, but definitely had some fun.

## Running

The filenames for the input text file to read are had coded, so for testing you need to change the source and recompile.

$ `fpc day9pt1.pas`

$ `./day9pt1`

$ `fpc day9pt2.pas`

$ `./day9pt2`

