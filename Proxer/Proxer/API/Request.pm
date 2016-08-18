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

package Proxer::API::Request;
use strict;
use warnings;
require v5.6.0;

use Carp;
use JSON;
use Data::Dumper;
use utf8;

sub new {
    my $self   = shift;
    my $Proxer = shift;
    my $opt    = {@_};
    my $post   = $opt->{data};
    my $me;
    my $request;

    $request->{post_data} = $post;

    $me->{proxer}    = $Proxer;
    $me->{api_class} = $opt->{class};
    $me->{REQUEST}   = $request;

    return bless( $me, $self );
}

sub _perform {
#    +------------------------------------------------
#    |  This Methods invokes the actual Request and 
#    |  also controls what the user get back.
#    |
#    |
#    +------------------------------------------------

    my $self = shift;

    my $Proxer    = $self->{proxer};
    my $api_class = $self->{api_class};
    my $request   = $self->{REQUEST};
    my $response;
    my $status;

    my $res = $Proxer->_api_access( $api_class, $request->{post_data} );

    if ( $Proxer->{rawmode} ) {
        # Manipulate the returment for rawmode
        if($res->is_error) {
            $Proxer->_seterror("HTTP err. " . $res->status_line);
            return undef;
        }
        else {
            return eval {decode_json($res->decoded_content)};
        }
    }

    if ( $res->is_error() ) {
        $Proxer->_seterror( "HTTP err. " . $res->status_line );

        $response->{error}   = 1;
        $response->{message} = "HTTP err. " . $res->status_line;
        $response->{code}    = 4000;
    }
    else {
        my $api = eval { decode_json( $res->decoded_content ) };

        unless ($api) {
            $Proxer->_seterror("JSON err. Json cannot be parsed");

            $response->{error}   = 1;
            $response->{message} = "JSON err. Json cannot be parsed";
            $response->{code}    = 5000;
        }
        else {
            $response = $api;
        }
    }

    $self->{RESPONSE} = $response;
    
    return $self;
}

sub failed {
    my $self     = shift;
    my $response = $self->{RESPONSE};
    
    if($response->{error} != 0) {
        return 1;
    }
    else {
        return undef;
    }
}

sub data {
    my $self     = shift;
    my $response = $self->{RESPONSE};

    return $response->{data};
}

sub error {
    my $self = shift;
    my $response = $self->{RESPONSE};
    
    return $response->{message};
}
