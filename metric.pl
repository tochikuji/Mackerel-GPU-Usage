use 5.014;

use strict;
use warnings;
use utf8;
use feature 'say';
use FindBin;
use lib "$FindBin::Bin/.";

use JSON::PP qw/encode_json/;
use smi_util;


my $json = {
  graphs => {
    'gpu.usage' => {
      'label' => 'GPU usage',
      'unit' => 'percentage',
      'metrics' => [],
    }
  }
};

my @usage = @{usage()};
my $n_gpu = 0;

for (@usage){

  push(@{$json->{graphs}->{'gpu.usage'}->{'metrics'}},
       {
         name => 'gpu'.$n_gpu,
         label => "GPU$n_gpu",
       }
     );

  ++$n_gpu;
}

if(defined($ENV{MACKEREL_AGENT_PLUGIN_META})){
  say '# mackerel-agent-plugin';
  say encode_json($json);
}

for(0..$n_gpu-1){
  say join("\t", ("gpu.usage.gpu$_", $usage[$_], time));
}

1;
