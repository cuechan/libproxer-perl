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

package Proxer::API::Access;
use strict;
use warnings;
use feature 'say';
require v5.6.0;

use Carp;
use LWP;
use LWP::UserAgent;
use HTTP::Headers;
use HTTP::Request;
use HTTP::Request::Common;
use HTTP::Response;
use JSON::XS;
use Data::Dumper;
use utf8;


sub new {
    my $class = shift;
    my $self;
    $self->{_params} = @_;


    my $Proxer_API = {@_}->{Proxer_API} or die "No proxer object passed";
    my $api_class  = {@_}->{api_class}  or die "No api-class passed";
    my $post_data  = {@_}->{post_data};


    # Download
    my $url = $Proxer_API->{BASE_URI}.$api_class;

    my $http_header = HTTP::Headers->new();

    $http_header->header('proxer-api-key' => $Proxer_API->{API_KEY});
    $http_header->header('Accept' => '*/*');
    $http_header->header('Content-Type' => 'application/x-www-form-urlencoded');

    my $payload = _to_url_econded_string($post_data);
    # warn $payload;
    my $http_req = HTTP::Request->new('POST', $url, $http_header, $payload);


    # warn Dumper $http_req;


    my $http_res = $Proxer_API->LWP->request($http_req);
    # warn Dumper $http_res;
    if( $http_res->is_error ) {
        $self->{is_error}  = 1;
        $self->{error_msg} = "Http-error";
        $self->{error}     = 4000 + int $http_res->code;
    }
    else {
        $self->{raw_res} = $http_res->decoded_content;

        my $api_res = eval {
            decode_json($self->{raw_res});
        };
        if ($@) {
            warn "parsing json failed!";
            print $self->{raw_res};
            return;
        }

        $self->{api_res} = $api_res;

        if( $api_res->{error} != 0 ) {
            $self->{is_error}  = 1;
            $self->{error_msg} = $api_res->{message};
            $self->{error}     = $api_res->{code};
        }
    }

    return bless( $self, $class );
}




sub failed {
    my $self = shift;

    if($self->{is_error}) {
        return 1;
    }
    else {
        return;
    }
}


sub data {
    my $self = shift;

    return $self->{api_res}->{data};
}

sub next_page {
    my $self = shift;

    return warn "Dummy function";
}

sub error {
    my $self = shift;

    return $self->{error_msg};
}

sub errcode {
    my $self = shift;

    return $self->{error};
}

sub raw {
    my $self = shift;

    return $self->{raw_res};
}



#########################
#                       #
#     PRIVATE STUFF     #
#                       #
#########################


sub _to_url_econded_string {
    my $data = shift;
    my @parameter;

    foreach( keys %$data ) {
        push(@parameter, join('=', $_, $data->{$_}));
    };

    my $url_string = join('&', @parameter);

    return $url_string;
}

1;
