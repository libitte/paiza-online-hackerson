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

my @m_D;
my $j = 0;
while (my $m_j = <STDIN>) {
	chomp($m_j);
	push(@m_D, $m_j);
	$j++;
	last if $j == $D;
}
#print("*** @m_D ***\n");


# print result
#----------------

while (my $m_j = shift(@m_D)) {
	print(get_max_pair($m_j, @p_N), "\n");
	#printf("*** campaign price/max pair price:%d/%d ***\n", $m_j, get_max_pair($m_j, @p_N));
}

sub get_max_pair {
	my $m_j = shift;
	my @p_N = @_;

	my @n = sort { $a <=> $b } grep { $_ < $m_j } @p_N;

	return 0 unless(@n);

	my $max_pair = 0;
	my %n_map = ();
	my $i = 0;
	@n_map{(1 .. scalar(@n))} = @n;

	for my $i (keys %n_map) {
		for $j (keys %n_map) {
			next if ($i == $j);
			my $sum = $n_map{$i} + $n_map{$j};
			next if ($sum > $m_j);
			if ($sum > $max_pair) {
				$max_pair = $sum;
			}
			else {
				next;
			}
		}
	}
	return $max_pair;
}

sub sum {
	my @s = @_;
	my $ret = 0;
	for (@s) {
		$ret += $_;
	}
	return $ret;
}

