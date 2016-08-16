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

package Proxer::User;

use strict;
use warnings;
our $VERSION = '0.01';

use Carp;
use JSON;
use Data::Dumper;
use utf8;


sub new {
    my $self = shift;
    my %opt = @_;
    
    if($opt{_intern}) {
        my $prxr_user;
        carp "Indirect call" if $ENV{DEBUG};
        
        $prxr_user->{Proxer} = $opt{_intern};
        $prxr_user->{Iam} = $self;
        
        return bless($prxr_user, $self);
    }
    else {
        carp "Direct call" if $ENV{DEBUG};;
        
        require Proxer;
        my $prxr = Proxer->new(@_);
        return $prxr->user();
    }
}

sub _id_or_name {
    my $ref = shift;
    my $id = shift;
    
    if($id =~ m/^\d+$/) {
        $$ref->{uid} = $id;
    }
    else {
        $$ref->{username} = $id;
    }
    
    return $$ref;
}


##########################
#                        #
#     Public Methods     #
#                        #
##########################

sub Login {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    my ($login, $password) = @_;
    my $url  = "user/login";
    
    my $data = $Proxer->_api_access($url, {username => $login, password => $password});
    return $data;
}

sub Logout {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    my $url  = "user/logout";
    
    my $data = $Proxer->_api_access($url);
    return $data;
}

sub Userinfo {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    my $id = shift;
    my $url = 'user/userinfo';
    my $post;
    
    _id_or_name(\$post, $id);
    
    my $res = $Proxer->_api_access($url, $post);
    
    return $res;
}

sub GetTopten {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    my $id = shift;
    my $kat = shift;
    my $url = 'user/topten';
    my $post;
    
    _id_or_name(\$post, $id);
    
    $post->{kat} = $kat;
    
    my $res = $Proxer->_api_access($url, $post);
    return $res;
}

sub GetList {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    my $id = shift;
    my $url = 'user/list';
    my $post;
    
    
    
    _id_or_name(\$post, $id);
    
    
    
    
    
    
    my $res = $Proxer->_api_access($url, $post);
    
    return $res;
}


1


__DATA__

Here is the Documentation:


=head1 Name

Proxer::Info

=head1 Functions

=head2 GetEntry

View [Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Entry)

Get the main information about an anime or manga.

    $anime = GetEntry($id);

Returns:
    $VAR1 = {
        'name' => 'One Piece',
        'state' => '2',
        'clicks' => '22858',
        'genre' => 'Abenteuer Action Comedy Drama Fantasy Martial-Art Mystery Shounen Superpower Violence',
        'fsk' => 'fsk12 bad_language violence',
        'rate_sum' => '82413',
        'rate_count' => '8851',
        'medium' => 'animeseries',
        'count' => '800',
        'description' => "Wir schreiben [...] der Piraten!\n(Quelle: Kaz\x{e9})",
        'license' => '2',
        'id' => '53',
        'kat' => 'anime'
    };
=cut
