#!/usr/bin/perl -wT
use strict;
use warnings;

my $op = shift;
my $xfile = shift;
my %DICT = ();

sub load_dict($)
{
	my $filename = shift;
	my $ifh;
	open($ifh, '<', $filename) || return 0;
	while (my $line = <$ifh>) {
		chomp($line);
		$line =~ s/\#.*//g;
		if ($line =~ /\#/ || $line =~ /^\s*$/) {
			next;
		}
		if ($line =~ /^(.+)$/) {
			$DICT{$line} = 1;
		}
	}
	close($ifh);

}

sub do_rewrite_file($$)
{
	my $op = shift;
	my $filename = shift;
	my $ifh;
	my $ofh;
	my $op_out = ($op eq 'filter-out' ? 1 : 0);
	open($ifh, '<', $filename) || return 0;
	open($ofh, '>', $filename . ".new~") || return 0;

	while (my $line = <$ifh>) {
		my $line_x = $line;
		chomp($line_x);
		if ($line_x =~ /\#/ || $line_x =~ /^\s*$/) {
			print $ofh $line;
			next;
		}
		if ($op_out) {
			if ($DICT{$line_x}) {
				next;
			}
		} else {
			if (!$DICT{$line_x}) {
				next;
			}
		}
		print $ofh $line;
	}

	close($ofh);
	close($ifh);

}

load_dict($xfile);

while (my $file = shift) {
	if ($file =~ /^([\x20-\x7f]+)$/) {
		$file = $1;
	}
	do_rewrite_file($op, $file);
}
