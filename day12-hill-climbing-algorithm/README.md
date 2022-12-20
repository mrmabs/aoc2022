# Day 12: Hill Climbing Algorithm

## Climbing the hill with GWBASIC

Well, GWBASIC I definitely know, but writing an algorithm I have no expereince with in the past from scratch, that was certianly interesting. Maybe GWASIC wasn't the best choice for this one.

Computation of each path was taking a not insignificant amount of time, so instead of making significant changes to the code and going for part two, I decided on a hybrid approach.

If you look at the code, you might see some lines where I attempted to prioritise the direction finding queue by ordering by closeness. This actually found a longer path on my map, and I ended up removing this optimisation. I decided in the intersts of finishing this challenge vs getting it right, that I would take shortcuts. I intend on coming back to this one at some stage.

Initially I did just look for the first "a" in the past back, but after careful examination of the map, all of those "a"s are holes, with no "b" to get back out. So my algorithm never made it to an "a" after leaving "S".

Because of the computation time in `dosbox` (even with `cycles=max`), for part 2, I ended up doing a bit of manual work. After looking at the map and working out Part 2 can on start from a limited subset of locations (not many "b"s to get to "c" height).  This approach turned out to be interesting, finding some interesting bugs I had not encountered in part 1.

I started off by plugging in a few numbers between 11 and 39, then gradually refined until I found the local minimums:

- 11: 503
- 12: 502
- 13: 501
- 14: 500
- 15: 501
- 16: 502

- 18: 502
- 20: 504
- 23: 505
- 24: 504
- 25: 503
- 26: 502
- 27: 501

- 30: 504

- 35: 509

- 39: 513

The mathematical theory behind this approach is to look for possible minimums in the data. Because of the way pthing works, a particular starting point will not be more than 1 above or blow its neighbour, otherwise it would be the shortest path. 35 with a 509, means that it is at least 5 more than the Start to End path, therefore, it is unlikely the answer is between 30 & 40. 17 is another example, while I did not calculate it for my map, it could be 501, 502 or 503; all of those guesses are greater than the minimum I found at 14.

While implementing the above in BASIC would be easy enough, the time to shuffle the code I have and adapt it to do this, plus th time to search the map, while fixing the bugs, would have gone beyond hours, into days.

## Personal history

This was my first programming language, and I played with it for many many years. After sinking my teeth into this challenge, I can definitely see how these older BASICs with basically no functions and GOTOs, are a lot more like Assembly than modern high level languages.

## Running

$ `gwbasic day12.bas`

OR

$ `gwbasic`
`load"day12.bas"`
`run`
