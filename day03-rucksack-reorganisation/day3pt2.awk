#!/usr/bin/gawk -f

# only count a-z, ignore A-Z and any other characters

function getnumber(decimal,temp, binary)
{    
	binary = "";    
	temp=decimal;    
	while( temp )        {        
		if ( temp%2==0 )        {            
			binary = "0" binary;                
		}        
		else        {            
			binary = "1" binary;                
		}        
		temp = int(temp/2);     
	}        
	return binary;
}

function wordbits(string, linebits) {
	linebits = 0
	len = length(string)
	for (i=1;i<=len;i++) {
		c = substr($0, i, 1)
		ltr = index(PRIO, c)
		linebits = or(linebits, 2^ltr)
	}
	return linebits
}


BEGIN { PRIO = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"; total = 0 }
{
	line1bits = wordbits($0);
	#print($0);
	getline;
	line2bits = wordbits($0);
	#print($0);
	getline;
	line3bits = wordbits($0);
	#print($0);

	group = and(and(line1bits, line2bits), line3bits);
	binstr = getnumber(group);

	counter = 0;
	for (i=1;i<=length(binstr);i++) {
		if (substr(binstr, i, 1) == 0) {
			++counter;
		}
	}
	total = total + counter
}

END {
	print total
}
