#!/usr/bin/gawk -f

# only count a-z, ignore A-Z and any other characters

BEGIN { PRIO = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"; total = 0 }
{
	len = length($0);
	half = int(len / 2)
	a = substr($0, 0, half);
	b = substr($0, half+1, half);

	for (i = 1; i <= half; i++) {
		c = substr(b, i, 1);
		#print c
		ltr = index(a, c);
		if (ltr > 0) {
			#++count[ltr];
			#print c
			total = total + index(PRIO, c)
			print index(PRIO, c)
			i = half+1
		}

	}
}

END {
	print total

}
