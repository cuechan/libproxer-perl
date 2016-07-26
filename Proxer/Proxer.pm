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
our $VERSION = '0.01';

use LWP;
use LWP::UserAgent;
use Data::Dumper;
use JSON::XS;
use lib 'Proxer';
use Proxer::Info;
use HTML::Entities;

=head1 Name

Module for interaction with proxer.me;

=head1 Synopsis

todo: Synopsis 

=cut

=head1 Functions

=cut

my $_Proxer;

sub new {
    
=head2 new

Create a proxer object

    my $prxr = Proxer->new(key => $api_key);
    
If you want to load the API-key from a file:

    my $prxr = Proxer->new(keyfile => 'path/to/api.key');
    
You also can load the key from a remote location using http or ftp:

    # NOT SUPPORTED YET!
    #my $prxr = Proxer->new(keylocation => 'http://keys.proxer.me/mykey');

=cut

# Finally here's the code:
    my $self = shift;
    my $opt  = {@_};
    my $proxer;
    
    
    
    if($opt->{key}) {
        $proxer->{API_KEY} = $opt->{key};
    }
    elsif($opt->{keyfile}) {
        open(FH, '<', $opt->{keyfile}) or die $!;
        my $key = <FH>;
        close(FH);
        chop($key);
        
        $proxer->{API_KEY} = $key;
    }
    else {
        error("No key defined");
        return undef;
    }
    
    error();
    
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
    
    return bless({LWP => $lwp, Proxer => $proxer}, $self);
}


sub Info {
    my $self = shift;
    my $opt = {@_};
    
    return Proxer::Info->new($self);
}


sub _api_access {
    my $self = shift;
    my ($url, $params) = @_;
    
    $params->{api_key} = $self->{Proxer}->{API_KEY};
    
    my $http_res = $self->{LWP}->post($url, $params);
    
    if($http_res->is_error()) {
        die $!;
    } else {
        my $api = decode_json($http_res->decoded_content);
        
        if($api->{error} != 0) {
            error("API-err: ".$api->{message});
            return undef;
        }
        else {
            my $data = exists $api->{data} ? $api->{data} : undef;
            
            unless($data) {
                error("Proxer did");
                return undef;
            }
            else {
                return $data;
            }
        }
    }
}

sub _html_decode {
    
}


sub error {
    my ($package, $file, $line) = caller();
    
    if($package ne __PACKAGE__) {
        my $self = shift;
        return $self->{LAST_ERROR};
    }
    else {
        $_Proxer->{LAST_ERROR} = @_;
    }
}

1; # End of Proxer
