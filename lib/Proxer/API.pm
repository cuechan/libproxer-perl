#!/usr/bin/perl

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

package Proxer::API;
use strict;
use warnings;

require v5.6.0;
our $VERSION = '0.01/dev';

use Carp;
use LWP;
use LWP::UserAgent;
use HTTP::Headers;
use HTTP::Request::Common;
use HTTP::Response;
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


sub new {
    my $self = shift;
    my $opt  = {@_};
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

    my $LWP = LWP::UserAgent->new();
    $LWP->agent("libproxer-perl/v0.01");
    $LWP->cookie_jar({});


    my $proxer = {
        BASE_URI => "http://proxer.me/api/v1/",
        API_KEY  => $api_key,
        LWP      => $LWP,
    };

    return bless( $proxer, $self );
}

#####################
# PRIVATE FUNCTIONS #
#####################


sub _seterror {
    my $self = shift;
    my $message;
    foreach (@_) {
        $message .= $_;
    }

    $self->{LAST_ERROR} = $message;
    return 1;
}

sub _http {
    my $self = shift;

    return $self->LWP->request(shift);
}

sub LWP {
    my $self = shift;

    return $self->{LWP};
}


#######################
#                     #
#     CONSTRUCTOR     #
#                     #
#######################

sub List {
    my $self = shift;

    return Proxer::API::List->new($self);
}

sub Info {
    my $self = shift;

    return Proxer::API::Info->new($self);
}

sub Notifications {
    my $self = shift;

    return Proxer::API::Notifications->new($self);
}

##########################
#                        #
#     PUBLIC METHODS     #
#                        #
##########################


sub error {
    my $self = shift;
    return $self->{LAST_ERROR} ? $self->{LAST_ERROR} : "undefined error";

}


sub make_foo {
    my $self = shift;

    $self->{foo} = 'bar';

    return 1;
}

1;    # End of Proxer::API

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
