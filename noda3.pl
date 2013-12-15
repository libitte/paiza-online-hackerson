#!/usr/bin/env perl
use strict;
use warnings;

use utf8;
binmode(STDOUT, ":utf8");

# parse args
#----------------

my $N_D = <STDIN>;
chomp($N_D);
my @N_D = split(/ /, $N_D);

my $N = $N_D[0];
my $D = $N_D[1];
#printf("*** N:%d, D:%d ***\n", $N_D[0], $N_D[1]);

my @p_N;
my $i = 0;
while (my $p_i = <STDIN>) {
	chomp($p_i);
	push(@p_N, $p_i);
	$i++;
	last if $i == $N;
}
#print("*** @p_N ***\n");

my $j = 0;
while (my $m_j = <STDIN>) {
	chomp($m_j);

	print(get_max_pair($m_j, \@p_N), "\n");
	#printf("*** campaign price/max pair price:%d/%d ***\n", $m_j, get_max_pair($m_j, @p_N));

	$j++;
	last if $j == $D;
}
#print("*** @m_D ***\n");

sub get_max_pair {
	my $m_j = shift;
	my $p_N = shift;

	# reduce useless elements
	#my @n = sort { $a <=> $b } grep { $_ < $m_j } @p_N;
	my @n = grep { $_ < $m_j } @$p_N;

	return 0 unless(@n);

	my $dest_index = scalar(@n) - 1;

	my $max = 0;
	for my $i (0 .. $dest_index) {
		for my $j ($i+1 .. $dest_index) {
			my $sum = $n[$i] + $n[$j];
			next if $sum > $m_j;
			$max = $sum if $sum >= $max;
		}
	}

	return $max;
}

#sub _max {
#	my ($n) = @_;
#	my @ns = sort { $b <=> $a } @$n;
#	return shift(@ns);
#}

#sub sum {
#	my ($s) = @_;
#	my $ret = 0;
#	for (@$s) {
#		$ret += $_;
#	}
#	return $ret;
#}


