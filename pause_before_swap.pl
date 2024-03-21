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
    print "This plugin will pause the alter prior to the table swap event while /tmp/pause_alter exists.\n" ;
    return ;
}

sub before_swap_tables {
    my ($self, %args) = @_ ;

    my $counter = 0 ;
    while ( -e "/tmp/pause_alter" ) {
        if ( $counter % 5 ) {
            print "Alter is paused. Delete /tmp/pause_alter to trigger the final stage.\n" ;
            sleep 1 ;
        }
    }

    print "/tmp/pause_alter does not exist or was removed. Resuming alter process.\n" ;

    return ;
}
1; # You're weird perl. Seriously. Get help.
