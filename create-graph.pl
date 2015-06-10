#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use File::Slurp::Tiny qw(read_lines);

my $file_name = shift || "../Datasets2014/raw_ampliado.csv";

my @passes = read_lines( $file_name );

if (!@passes) {
    die "Algo no va";
}

my (%nodes,%devices);
my @edges;

for my $p (@passes[1..$#passes]) {
    my ($id_nodo, $id_dispositivo ) = split(",",$p);
    $nodes{$id_nodo}++;
    $devices{$id_dispositivo}{$id_nodo}++;
}

my @dobles_pasos = grep( (keys %{$devices{$_}}) > 1, keys %devices );

for my $p (@dobles_pasos) {
  my @nodes = keys %{$devices{$p}};
  for ( my $i = 0; $i <= $#nodes; $i++ ) {
    for ( my $j = $i+1; $j <= $#nodes; $j++ ) {
      say "$nodes[$i] $nodes[$j]";
    }
  }
}
