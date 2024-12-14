#!/usr/bin/perl
use strict;
use warnings;
use File::Spec;

# Expand the path to the SSH config file
my $ssh_config = File::Spec->catfile($ENV{HOME}, '.ssh', 'hosts');

# Open the SSH config file
open(my $fh, '<', $ssh_config) or die "Could not open file '$ssh_config': $!";

# Parse the config file
while (my $line = <$fh>) {
    # Look for lines starting with 'Host' (ignoring comments and whitespace)
    if ($line =~ /^\s*Host\s+([^\s#]+)/) {
        my $alias = $1;
        
        # Skip '*' and '?' wildcards
        next if $alias =~ /[*?]/;
        
        # Print the alias
        print "$alias\n";
    }
}

close($fh);
