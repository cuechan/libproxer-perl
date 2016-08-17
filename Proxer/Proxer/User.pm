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

require v5.6.0;
our $VERSION = 0.01;
use Exporter 'import';
our @EXPORT = qw(
    Login
    Logout
    Userinfo
    GetTopten
    GetList
    GetLatestComment
);

use Carp;
use JSON;
use Data::Dumper;
use utf8;


###########################
#                         #
#         Methods         #
#                         #
###########################

sub Login {
    my $self = shift;
    my ($login, $password) = @_;
    my $url  = "user/login";
    
    my $data = $self->_api_access($url, {username => $login, password => $password});
    return $data;
}

sub Logout {
    my $self = shift;
    my $url  = "user/logout";
    
    my $data = $self->_api_access($url);
    return $data;
}

sub Userinfo {
    my $self = shift;
    my $id = shift;
    my $url = 'user/userinfo';
    my $post;
    
    _id_or_name(\$post, $id);
    
    my $res = $self->_api_access($url, $post);
    
    return $res;
}

sub GetTopten {
    my $self = shift;
    my $id = shift;
    my $kat = shift;
    my $url = 'user/topten';
    my $post;
    
    _id_or_name(\$post, $id);
    
    $post->{kat} = $kat;
    
    my $res = $self->_api_access($url, $post);
    return $res;
}

sub GetList {
    my $self = shift;
    my $id = shift;
    my $url = 'user/list';
    my $post;
    
    _id_or_name(\$post, $id);
    
    
    
    my $res = $self->_api_access($url, $post);
    
    return $res;
}

sub GetLatestComment {
    my $self = shift;
    my $url = 'user/comments';
    my $opt = {@_};
    
    _id_or_name(\$opt, $opt->{id});
    
    my $res = $self->_api_access($url, $opt);
    
    return $res;
}


#########################
#                       #
#       Functions       #
#                       #
#########################

sub _id_or_name {
    my $ref = shift;
    my $id = shift;
    
    if($id =~ m/^\d+$/) {
        delete $$ref->{username};
        delete $$ref->{id};
        $$ref->{uid} = $id;
    }
    else {
        delete $$ref->{id};
        $$ref->{username} = $id;
    }
    
    return $$ref;
}


1;


__DATA__

Here is the Documentation:


=head1 Name

Proxer::Info

=head1 Methods

=head2 Login

Login a user.

    $proxer->Login($usernamem §password);

View [Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/User#Login)

=head2 Logout

Oppsite of login

    $proxer->Logout();

Returns nothing.

View [Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/User#Logout)

=head2 Userinfo

Todo: userinfo

=cut
