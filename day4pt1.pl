my $file = $ARGV[0] or die;
open(my $data, '<', $file) or die;

while (my $line = <$data>)
{
	chomp $line;

	# Split the line and store it
	# inside the words array
	my @words = split ",", $line;

	for (my $i = 0; $i <= 2; $i++) {
		print "$words[$i] ";
	}
	print "\n";
}
