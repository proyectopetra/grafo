#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use File::Slurp::Tiny qw(read_lines);

my $traffic_data_name = shift || "../Datasets2014/raw_ampliado.csv";
my $node_data_name = shift || "../Datasets2014/nodos_info.csv";


my $output =<<EOC;
library(igraph)
traffic.graph <- graph.empty(n=0)
EOC

my @nodes_info = read_lines( $node_data_name );
my %nodes_info;
for my $i ( @nodes_info ) {
  my ($ID,$foo,$bar,$name) = split(",",$i);
  $nodes_info{$ID}=$name;
}

my @passes = read_lines( $traffic_data_name );

if (!@passes) {
    die "Algo no va\n";
}

my (%nodes,%devices);
my @edges;

for my $p (@passes[1..$#passes]) {
    my ($id_nodo, $id_dispositivo ) = split(",",$p);
    $nodes{$id_nodo}++;
    $devices{$id_dispositivo}{$id_nodo}++;
}

for my $n (keys %nodes) {
  $output .= "\ntraffic.graph <- traffic.graph + vertex($nodes_info{$n})";
}

my @dobles_pasos = grep( (keys %{$devices{$_}}) > 1, keys %devices );

my %pesos;
for my $p (@dobles_pasos) {
  my @nodes = keys %{$devices{$p}};
  for ( my $i = 0; $i <= $#nodes; $i++ ) {
    for ( my $j = $i+1; $j <= $#nodes; $j++ ) {
      if ( $nodes[$i] < $nodes[$j] ) {
	$pesos{$nodes[$i]}{$nodes[$j]}++;
      } else {
	$pesos{$nodes[$j]}{$nodes[$i]}++;
      }
    }
  }
}

for my $k (keys %pesos ) {
  for my $kk (keys %{$pesos{$k}}) {
      $output .= "\ntraffic.graph <- traffic.graph + edge($nodes_info{$k},$nodes_info{$kk},weight=$pesos{$k}{$kk})"
  }
}

$output .=<<EOC;

plot(traffic.graph, layout = layout.fruchterman.reingold,
      vertex.size = 10,
      vertex.color="gray",
      vertex.frame.color= "white",
      vertex.label.color = "blue",
      vertex.label.family = "sans",
      edge.width=log(E(traffic.graph)\$weight),  
      edge.color="black")
EOC

say $output;
