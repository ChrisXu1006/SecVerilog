#!/usr/bin/perl

use Term::ANSIColor;
use Getopt::Std;
use strict vars;

my $z3home =""; # specify z3 home directory
my $iveriloghome = ""; # specify iverilog home directory
my $z3option = "smt2";
my $secoption = "";

my $fail_counter = 0;
my $counter = 0;

sub print_ok {
  print colored("verified\n", 'green');
}

sub print_fail {
  print colored("fail\n", 'red');
}

# help message
sub help_message() {
  print "Usage: secverilog.pl [-F depfun] [-l lattice] [-z] file.v \n";
  print "-F depfun: provide a z3 file that defines type-level functions \n";
  print "-l lattice: provide a z3 file that defines a lattice of security labels \n";
  print "-z: quit after type checking \n";
}

our ($opt_F, $opt_l, $opt_z, $assert);
# parse options passed to SecVerilog
if (not getopts("F:l:z")) {
  help_message();
  exit(1);
}

if ($opt_F) { $secoption .= "-F $opt_F "; }
if ($opt_l) { $secoption .= "-l $opt_l "; }
if ($opt_z) { $secoption .= "-z "; }

# my @files = <*>;
my @files = ();
foreach (@ARGV)
{
  push (@files, "$_");
}

foreach my $file (@files) {
  if (-f $file and $file =~ /\.v$/) {
    # run iverilog to generate constraints
    print "Compiling file $file\n";
    my $iverilogbin = "$iveriloghome"."iverilog";
    `$iverilogbin $secoption $file`;
  }
}

foreach my $file (@files) {
  if (-f $file and $file =~ /\.v$/) {
    my ($prefix) = $file =~ m/(.*)\.v$/;
    print "Verifying file $file\n";

    # read the output of Z3
    my $z3bin = "$z3home"."z3";
    my $str = `$z3bin -$z3option $prefix.z3`;
    $file = "$prefix.z3";
    
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

