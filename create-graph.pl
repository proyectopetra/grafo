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

my $indice = 0;
my %indices;
for my $n (keys %nodes) {
  $indices{$n} = $indice++;
}

my @dobles_pasos = grep( (keys %{$devices{$_}}) > 1, keys %devices );

my %pesos;
for my $p (@dobles_pasos) {
  my @nodes = keys %{$devices{$p}};
  for ( my $i = 0; $i <= $#nodes; $i++ ) {
    for ( my $j = $i+1; $j <= $#nodes; $j++ ) {
      if ( $nodes[$i] < $nodes[$j] ) {
	$pesos{$indices{$nodes[$i]}}{$indices{$nodes[$j]}}++;
      } else {
	$pesos{$indices{$nodes[$j]}}{$indices{$nodes[$i]}}++;
      }
    }
  }
}

for my $k (keys %pesos ) {
  for my $kk (keys %{$pesos{$k}}) {
    say "$k $kk";
  }
}
