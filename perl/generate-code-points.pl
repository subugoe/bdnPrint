#!/usr/bin/env perl

use autodie;
use bigint;
use strict;
use utf8;
use warnings;

use Unicode::UCD qw(charinfo);

print "\"unicode code points for decomposed lower case letters\",\"\"\n";
print "\"dec\",\"hex\"\n";

for (my $i = 0; $i <= 1024; $i++) {
  my $charinfo = charinfo($i);
  my $decomposition = $charinfo->{decomposition};
  my $category = $charinfo->{category};

  if ($category and lc($category) eq "ll" and not($decomposition)) {
    my $hex = $i->as_hex;
    $hex =~ s/^0x//;
    $hex = uc($hex);

    print "$i,\"$hex\"\n";
  }
}
