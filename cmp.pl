#!/usr/bin/env perl
# FILENAME: cmp.pl
# CREATED: 07/23/14 03:32:40 by Kent Fredric (kentnl) <kentfredric@gmail.com>
# ABSTRACT: Income Compare

use strict;
use warnings;
use utf8;

my $new_flat_tax = ( shift @ARGV ) / 100;

printf qq[%s,%s,%s,%s\n], "Gross Annual Income",
                       ( sprintf "Weekly Savings under new Scheme at %3.2f%%", $new_flat_tax * 100 ),
                       "Weekly Income under new scheme",
                       "Weekly Income under old scheme";


for my $i ( 1 .. 1000 ) {
  my $new = new_income( $i * 1000 );
  my $old = old_income( $i * 1000 );
  printf qq[%dk,%d/w,%d/w,%d/w\n], $i, $new - $old, $new, $old ;
}


sub old_income {
  my ( $yearly ) = shift;
  if ( $yearly <= 38_000 ) {
    return ( $yearly * ( 1 - 0.195 ) ) / 52;
  }
  if ( $yearly <= 60_000 ) {
    return ( $yearly * ( 1 - 0.33 ) ) / 52;
  }
  return ( $yearly * ( 1 - 0.39 ) ) / 52;
}

sub new_income {
  my ( $yearly ) = shift;

  return ( $yearly / 52 ) if $yearly < 20_000;
  my $excess = ( $yearly - 20_000 ) * ( 1 - $new_flat_tax );
  return ( 20_000 + $excess ) / 52;
}


