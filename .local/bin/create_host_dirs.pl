#!/usr/bin/perl
use strict;
use warnings;
use File::Spec;
use File::Path qw(make_path);

# Expand the path to the SSH config file
my $ssh_config = File::Spec->catfile($ENV{HOME}, '.ssh', 'hosts');

# Open the SSH config file
open(my $fh, '<', $ssh_config) or die "Could not open file '$ssh_config': $!";

# Directory to create host folders
my $hosts_dir = $ENV{XDG_STATE_HOME} ? 
    File::Spec->catdir($ENV{XDG_STATE_HOME}, 'hosts') : 
    File::Spec->catdir($ENV{HOME}, '.local', 'state', 'hosts');

# Ensure the hosts directory exists
make_path($hosts_dir) unless -d $hosts_dir;

# Parse the config file
while (my $line = <$fh>) {
    # Look for lines starting with 'Host' (ignoring comments and whitespace)
    if ($line =~ /^\s*Host\s+([^\s#]+)/) {
        my $alias = $1;
        
        # Skip '*' and '?' wildcards
        next if $alias =~ /[*?]/;
        
        # Create directory for the alias
        my $host_path = File::Spec->catdir($hosts_dir, $alias);
        
        # Create the directory if it doesn't exist
        make_path($host_path) unless -d $host_path;
        
        print "Created directory for host: $host_path\n";
    }
}

close($fh);
