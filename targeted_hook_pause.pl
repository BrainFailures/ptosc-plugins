# Lets you pause the table swap until a certain file ( /tmp/pause_alter ) is deleted.

use strict;

package pt_online_schema_change_plugin;

sub new {
    my ($class, %args) = @_ ;
    my $self = { %args } ;
    return bless $self, $class ;
}

sub init {
    my ($self, %args) = @_ ;
    print "Loaded Plugin: pause_before_swap\n" ;
    print "This plugin will pause the alter prior to the table swap event while /tmp/pause_before_swap exists.\n" ;
    return ;
}

sub on_copy_rows_after_nibble {
    my ($self, %args) = @_ ;
    my $counter = 0 ;

    while ( -e "/tmp/pause_copy_rows" ) {
        if ( $counter % 5 ) {
            print "Found /tmp/pause_copy_rows. Remove it to continue the copy process." ;
        }
        $counter++ ;
    }

sub before_swap_tables {
    my ($self, %args) = @_ ;

    my $counter = 0 ;
    while ( -e "/tmp/pause_before_swap" ) {
        if ( $counter % 5 ) {
            print "Alter is paused. Delete /tmp/pause_before_swap to trigger the final stage.\n" ;
            sleep 1 ;
        }
        $counter++ ;
    }

    print "/tmp/pause_alter does not exist or was removed. Continuing.\n" ;

    return ;
}
1; # You're weird perl. Seriously. Get help.
