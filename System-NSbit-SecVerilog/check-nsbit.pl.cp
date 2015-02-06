#!/usr/bin/perl

use Term::ANSIColor;

my $z3home ="z3";
my $option = "smt2";
my $iverilog = "iverilog";

my $fail_counter = 0;
my $counter = 0;

sub print_ok {
  print colored("verified\n", 'green');
}

sub print_fail {
  print colored("fail\n", 'red');
}

# type check all files with .v extension in current directory
# first generate the z3 files
# my @files = <*>;
my @files = ("plab5-mcore-TestMem_1port_sep.v","plab5-mcore-memreqcmsgunpack.v","plab5-mcore-memreqcmsgpack.v","plab5-mcore-memrespcmsgpack.v","vc-mem-msgs.v","vc-queues.v");
#my @files = ("plab4-net-RingNetAlt-sep.v","plab4-net-demux.v","plab4-net-RouterAlt.v", "plab4-net-RouterInputCtrl-Arb.v", "plab4-net-RouterAdaptiveInputTerminalCtrl.v", "plab4-net-RouterOutputCtrl.v", "plab4-net-RouterInputCtrl.v", "plab4-net-AdaptiveRouteCompute.v", "vc-crossbar3.v","vc-crossbar3-sd.v", "vc-mux3.v", "vc-mux3-sd.v","vc-mux2-sd.v", "vc-queues.v", "vc-mem-msgs.v");
#my @files = ("plab5-mcore-resp-mem2net-adapter.v","plab5-mcore-memrespcmsgpack.v","vc-net-msgpack.v");
foreach my $file (@files) {
  if (-f $file and $file =~ /\.v$/) {
    # run iverilog to generate constraints
    print "Compiling file $file\n";
    `$iverilog -z $file`;
    #system ($iverilog, "-z", $file);
  }
}

my @files = <*>;
foreach my $file (@files) {
  if (-f $file and $file =~ /\.z3$/) {
    my ($prefix) = $file =~ m/(.*)\.z3$/;
    print "Verifying module $prefix ";

    # read the output of Z3
    my $str = `z3 -$option $file`;
    
    # parse the input constraint file to identify assertions
    open(FILE, "$file") or die "Can't read file $file\n";
    my @assertions = ();
    my $assertion;
    my $isassertion = 0;
    $counter = 0;

    while (<FILE>) {
      if (m/^\(push\)/) {
        $assertion = "";
        $isassertion = 1;
      }
      elsif (m/^\(check-sat\)/) {
        push(@assertions, $assertion);
        $isassertion = 0;
      }
      elsif ($isassertion) {
        $assertion = $_;
      }
    }
    
    close (FILE);
    
    # find "unsat" assertions, and output the corrensponding comment in constraint source file
    my $errors = "";
	#print $str;
    for(split /^/, $str) {
      if (/^sat/) {
        $assert = @assertions[$counter];
        $errors .= $assert;
	$fail_counter ++;
        $counter ++;
      }
      elsif (/^unsat/) {
        $counter ++;
      }
    }
    if ($errors eq "") {
      print_ok();
    }
    else {
      print_fail();
      print $errors;
    }
  }
}

print "Total: $fail_counter assertions failed\n";

