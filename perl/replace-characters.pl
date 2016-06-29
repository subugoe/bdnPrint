#!/usr/bin/env perl

use autodie;
use strict;
use utf8;
use warnings;

use open ":std", ":utf8";

use File::Slurp;

my $tmp1 = read_file("tmp/tmp-1.tex", binmode => ":utf8");

$tmp1 =~ s/\x{2192}/{\\ra}/g;

print $tmp1;
