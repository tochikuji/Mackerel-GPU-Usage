use 5.014;

use strict;
use warnings;
use utf8;
use feature 'say';

use JSON::PP qw/encode_json/;


sub usage {
  my $smi_output = `nvidia-smi`;

  my @usage = ();
  my $n_gpu = 0;

  for my $match ($smi_output =~ m/\d+MiB\s*\/\s*\d+MiB/g){
    $match =~ /(\d+)MiB\s*\/\s*(\d+)MiB/;
    push @usage, $1 / $2;
  }

  return \@usage;
}

1;
