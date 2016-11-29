use 5.014;

use strict;
use warnings;
use utf8;
use feature 'say';
use FindBin;
use lib "$FindBin::Bin/.";

use List::Util qw/reduce/;
use smi_util;


sub all(&@){
  my $f = shift;

  for(@_){
    return 0 unless $f->($_);
  }

  return 1;
}

sub any(&@){
  my $f = shift;

  for(@_){
    return 1 if $f->($_);
  }

  return 0;
}


my @usage = @{usage()};
my $n_gpu = 0;

if(all{$_ > 0.4} @usage){
  say 'All GPUs are currently used.';
  exit 2;
}

if(any{$_ > 0.4} @usage){
  say 'At least one GPU is currently used.';
  exit 1;
}

say 'All GPU are not in use.';
exit 0;
