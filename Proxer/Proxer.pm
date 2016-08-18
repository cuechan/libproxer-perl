#*************************************************************
# Copyright 2016 Paul Maruhn.
#
# This program is distributed under the MIT (X11) License:
# <http://www.opensource.org/licenses/mit-license.php>
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
#*************************************************************

package Proxer;
use strict;
use warnings;

require v5.6.0;
our $VERSION = 0.01;
use lib 'Proxer';

use Carp;
use LWP;
use LWP::UserAgent;
use Data::Dumper;
use JSON::XS;

#
# +--------------+
# |              |
# |     TO DO    |
# |              |
# +--------------+
#
# Todo: Function for postprocessing api answers
# Todo: A lot of other stuff

sub import {
    my $module = shift;

    # Unfortunately this need to be hardcoded
    foreach (@_) {
        if ( $_ eq 'Info' ) {
            require Proxer::Info;
            Proxer::Info->import();
        }
        elsif ( $_ eq 'Notifications' ) {
            require Proxer::Notifications;
            Proxer::Notifications->import();
        }
        elsif ( $_ eq 'List' ) {
            require Proxer::List;
            Proxer::List->import();
        }
        elsif ( $_ eq 'User' ) {
            require Proxer::User;
            Proxer::User->import();
        }
        else {
            carp "$_ is not part of libproxer";
        }

    }
}

sub new {
    my $self = shift;
    my $opt  = {@_};
    my $proxer;
    my $api_key;

    if ( $opt->{key} ) {
        $api_key = $opt->{key};
    }
    elsif ( $opt->{keyfile} ) {
        open( FH, '<', $opt->{keyfile} )
          or die "keyfile: $opt->{keyfile} not found on disk";
        my $key = <FH>;
        close(FH);
        chop($key);

        $api_key = $key;
    }
    else {
        croak("No key defined");
        return undef;
    }
    
    $proxer->{rawmode} = $opt->{rawmode} != 0 ? 1 : undef;

    my $lwp;
    if ( $opt->{UserAgent} ) {
        $lwp = $opt->{UserAgent};
    }
    else {
        $lwp = LWP::UserAgent->new();

        $lwp->agent("libproxer2-perl/v$VERSION ($^O; perlv$])");
        $lwp->cookie_jar( {} );    # use temporary cookie jar
        $lwp->timeout(30);         # set timeout to 5 seconds
    }

    $proxer = {
        BASE_URI => "https://proxer.me/api/v1/",
        API_KEY  => $api_key,
        LWP      => $lwp,
    };

    return bless( $proxer, $self );
}

##################
# MAIN FUNCTIONS #
##################

sub info {
    require Proxer::Info;
    my $self = shift;
    my $opt  = {@_};

    return Proxer::Info->new( _intern => $self );
}

sub notifications {
    require Proxer::Notifications;
    my $self = shift;
    my $opt  = {@_};

    return Proxer::Notifications->new( _intern => $self );
}

sub user {
    require Proxer::User;
    my $self = shift;
    my $opt  = {@_};

    return Proxer::User->new( _intern => $self );
}

sub list {
    require Proxer::List;
    my $self = shift;
    my $opt  = {@_};

    return Proxer::List->new( _intern => $self );
}

#####################
# PRIVATE FUNCTIONS #
#####################

sub _api_access {
    my $self = shift;

    my ( $api_class, $params ) = @_;

    my $uri = $self->{BASE_URI} . $api_class;
    $params->{api_key} = $self->{API_KEY};

    warn "API-URL: ", $uri if $ENV{DEBUG};
    warn "PARAMS: " . Dumper($params) if $ENV{DEBUG};

    my $http_res = $self->{LWP}->post( $uri, $params );
    
    return $http_res;
}

# todo: postprocess function

sub page {
    my $self  = shift;
    my $total = shift;

    # todo: More Magic
}

sub _seterror {
    my $self = shift;
    my $message;
    foreach (@_) {
        $message .= $_;
    }

    $self->{LAST_ERROR} = $message;
    return 1;
}

sub error {
    my $self = shift;
    return $self->{LAST_ERROR} ? $self->{LAST_ERROR} : "undefined error";

}

1;    # End of Proxer

__DATA__

DOCUMENTATION:


=head1 Name

Module for interaction with proxer.me;

=head1 Synopsis

todo: Synopsis 

=head1 Functions

=head2 new

Create a proxer object

    my $prxr = Proxer->new(key => $api_key);
    
If you want to load the API-key from a file:

    my $prxr = Proxer->new(keyfile => 'path/to/api.key');
    
You also can load the key from a remote location using http or ftp:

    # NOT SUPPORTED YET!
    #my $prxr = Proxer->new(keylocation => 'http://keys.proxer.me/mykey');

=cut
