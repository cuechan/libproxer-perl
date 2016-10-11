# Name

Proxer::ServerStatus

# Synosis

        use Proxer::ServerStatus qw(check_server_status); # import the required function into our namespace
        
        my $proxerstatus = check_server_status() or die "cant check server status: ", $Proxer::ServerStatus::ERROR;
        foreach( keys %$proxerstatus ) {
                print $_;
                
                if( !$proxerstatus->{$_} ) {
                        print " is down\n";
                }
                else {
                        print " is up\n";
                }
        }

# Varibles and errorhandling

There actually only one exported variable `$Proxer::ServerStatus::ERROR`.

This variable stores the most recent error message.

        $status = check_server_status() or die $Proxer::ServerStatus::ERROR;
        

This code exits and prints the error message when the check failed

# functions

All necessary functions need to be imported (see synopsis)

## check\_server\_status

Checks the current server status using proxer.de API.

It returns a heshref similar like this:

        $VAR1 = {
                'helper' => 1,
                'stream_44' => 1,
                'stream_37' => undef,
                'stream_43' => 1,
                'stream_30' => 1,
                'stream_41' => 1,
                'stream_50' => 1,
                'teamspeak' => 1,
                'manga_1' => 1,
                'manga_5' => 1,
                'manga_4' => 1,
                'stream_39' => 1,
                'cdn' => 1,
                'stream_38' => 1,
                'stream_45' => 1,
                'stream_27' => 1,
                'stream_47' => 1,
                'manga_3' => 1,
                'stream_36' => 1,
                'stream_48' => 1,
                'stream_14' => 1,
                'manga_0' => 1,
                'stream_40' => 1,
                'manga_2' => 1,
                'mysql' => 1,
                'stream_46' => 1,
                'stream_49' => 1,
                'stream' => 1,
                'project_t' => 1,
                'web' => 1,
                'stream_42' => 1,
                'stream_3' => 1
        };

As you can see the server status is `1` when its online otherwise it will be `undef`.
