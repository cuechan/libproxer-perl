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

use 5.006;
use strict;
use warnings;
our $VERSION = 0.01;

use LWP;
use LWP::UserAgent;
use Data::Dumper;
use JSON::XS;
use lib 'Proxer';
use Proxer::Info;
use Proxer::Notifications;
use Proxer::User;


my $_Proxer;

sub new {
    my $self = shift;
    my $opt  = {@_};
    my $proxer;
    my $api_key;
    
    
    if($opt->{key}) {
        $api_key = $opt->{key};
    }
    elsif($opt->{keyfile}) {
        open(FH, '<', $opt->{keyfile}) or die "keyfile: $opt->{keyfile} not found on disk";
        my $key = <FH>;
        close(FH);
        chop($key);
        
        $api_key = $key;
    }
    else {
        die("No key defined");
        return undef;
    }
    
    my $lwp;
    if($opt->{UserAgent}) {
        $lwp = $opt->{UserAgent};
    }
    else {
        $lwp = LWP::UserAgent->new();
        
        $lwp->agent("libproxer2-perl/v$VERSION ($^O; perlv$]))");
        $lwp->cookie_jar({}); # use temporary cookie jar
        $lwp->timeout(30);    # set timeout to 30 seconds
    }
    
    $proxer = {
        BASE_URI => "https://proxer.me/api/v1/",
        API_KEY => $api_key,
        LWP => $lwp,
    };
    
    return bless({$self => bless($proxer, $self)}, $self);
}






##################
# MAIN FUNCTIONS #
##################

sub info {
    my $self = shift;
    my $opt = {@_};
    
    return Proxer::Info->new(_intern => $self);
}

sub notifications {
    my $self = shift;
    my $opt = {@_};
    
    return Proxer::Notifications->new(Proxer => $self);
}

sub user {
    my $self = shift;
    my $opt = {@_};
    
    return Proxer::User->new(Proxer => $self);
}


#####################
# PRIVATE FUNCTIONS #
#####################

sub _api_access {
    my $self = shift;
    
    my ($api_class, $params) = @_;
    
    my $uri = $self->{BASE_URI}.$api_class;
    $params->{api_key} = $self->{API_KEY};
    
    my $http_res = $self->{LWP}->post($uri, $params);
    
    
    
    ##
    # Access the API
    ##
    
    if($http_res->is_error()) {
        seterror("HTTP err. ". $http_res->status_line);
        return undef;
    } else {
        my $api = decode_json($http_res->decoded_content);
        
        if($api->{error} != 0) {
            seterror("API-err: ".$api->{message});
        }
        return $api ? $api : undef;
    }
}

# todo: postprocess function

sub page {
    my $self = shift;
    my $total = shift;
    
    
    
    
}


sub seterror {
    foreach(@_) {
        $_Proxer->{LAST_ERROR} .= $_;
    }
}

sub error {
    my $self = shift;
    return $_Proxer->{LAST_ERROR} ? $_Proxer->{LAST_ERROR} : "no error occured";
    
}

1; # End of Proxer


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
