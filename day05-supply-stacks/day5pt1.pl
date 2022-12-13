# I forgot how frustrating Perl was, lots of debugging needed here
#
# I'm sure there is a better way, but this was "my way"...
#

# hard coded :(
my @piles = ([], [], [], [], [], [], [], [], []);

foreach my $line (<STDIN>) {
	chomp($line);
	my $firstchar = $line;
	$firstchar =~ s/^\s+//;
       	$firstchar = substr $firstchar, 0, 1;
	if ($firstchar eq "m") {
		@splitline = split(" ", $line);
		#print @splitline, "\n";
		# hard coded
		$qty = $splitline[1];
		$from = $splitline[3] - 1;
		$to = $splitline[5] - 1;
		#print $qty, " ", $from, " ", $to, "\n";

		my @q = (1..$qty);
		foreach (@q) {
			my $temp = pop @{$piles[$from]};
			push @{ $piles[$to] }, $temp;
		}
	} elsif ($firstchar eq "[") {
		my @i = (1..9);
		for (@i) {
			my $iter = $_;
			#print (($iter * 4) - 2);
			my $char = substr $line, (($iter * 4) - 3), 1;
			#print $char, "\n";
			unless ($char eq " ") {
				print $char, "\n";
				#push @{ @piles[$iter-1] }, $char;
				unshift@{ @piles[$iter-1] }, $char
			}
		}
	}

	print "@{$piles[0]}\n";
	print "@{$piles[1]}\n";
	print "@{$piles[2]}\n";
	print "@{$piles[3]}\n";
	print "@{$piles[4]}\n";
	print "@{$piles[5]}\n";
	print "@{$piles[6]}\n";
	print "@{$piles[7]}\n";
	print "@{$piles[8]}\n";
	print "-----\n";
}


#print "@{$piles[0]}\n";
#print "@{$piles[1]}\n";
#print "@{$piles[2]}\n";

print pop @{$piles[0]};
print pop @{$piles[1]};
print pop @{$piles[2]};
print pop @{$piles[3]};
print pop @{$piles[4]};
print pop @{$piles[5]};
print pop @{$piles[6]};
print pop @{$piles[7]};
print pop @{$piles[8]};
print "\n";

