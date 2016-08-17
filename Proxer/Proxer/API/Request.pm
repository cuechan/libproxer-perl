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
    my $self = shift;
    my $proxer = shift;
    my $args = {@_};
    my $data = $args->{data};
    my $req;
    
    $req->{API_CLASS} = $args->{class};
    $req->{REQUEST_DATA} = $args->{data} ? $args->{data} : {};
    
    if($args->{obj}) {
        $req->{data_type} = 1;
    }
    elsif($args->{list}) {
        $req->{data_type} = 2;
        
        $req->{API_CLASS} = $args->{class};
        $req->{REQUEST_DATA} = $args->{data} ? $args->{data} : {};
        
        $req->{PAGE} = $data->{p} ? $data->{p} : 1;
        $req->{PAGE_LIMIT} = $data->{limit} ? $data->{limit} : undef;
    }
    else {
        croak "Datatype not supported";
    }
    
    $req->{CACHE} = undef;
    $req->{PROXER} = $proxer;
    
    return bless($req, $self);
}

sub _perform {
    my $self = shift;
    my $Proxer = $self->{PROXER};
    
    my $res = $Proxer->_api_access($self->{API_CLASS}, $self->{REQUEST_DATA});
    
    $self->{RESPONSE_DATA} = $res;
    
    
    return $res;
}

sub failed {
    my $self = shift;
    my $response = $self->{RESPONSE_DATA};
    
    if($response->{error} != 0) {
        return $response->{error};
    }
    else {
        return undef;
    }
}

sub error {
    my $self = shift;
    my $data = $self->{RESPONSE_DATA};
    
    return $data->{message};
    return "Not implemented yet";
}

sub data {
    my $self = shift;
    
    if($self->{data_type} == 1) {
        warn "DATATYPE IS OBJ";
        return $self->{RESPONSE_DATA}->{data};
    }
    elsif($self->{data_type} == 2) {
        warn "DATATYPE IS ARRAY";
        return @{$self->{RESPONSE_DATA}->{data}};
    }
    else {
        carp "Response type is not known";
        return undef;
    }
    return;
}

sub next {
    my $self = shift;
    croak if $self->{data_type} != 2;
    
    my $proxer = $self->{PROXER};
    
    my $data = $self->{RESPONSE_DATA};
    
    
    if(@{$data->{data}} < 1 ) {
        my $post;
        
        $post = $self->{REQUEST_DATA};
        $post->{p} = $self->{PAGE}++;
        $post->{limit} = $self->{PAGE_LIMIT};
        
        my $res = $self->_perform($self->{API_CLASS}, $post);
        
        warn Dumper $res;
        
        die "FATAL HTTP ERROR" if !$res;
    }
    
    if(@{$data->{data}} >= 1) {
        return shift(@{$data->{data}});
    }
    else {
        return undef;
    }
    
    
}
