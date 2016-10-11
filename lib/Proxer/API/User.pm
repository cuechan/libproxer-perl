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

package Proxer::API::User;
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

use lib '..';
use Proxer::API::Request;
use Carp;
use JSON::XS;
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
    my $api_class  = "user/login";
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => {
            username => $login,
            password => $password
        },
    );
    
    return $res->_perform;
}

sub Logout {
    my $self = shift;
    my $api_class  = "user/logout";
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
    );
    
    return $res->_perform;
}

sub Userinfo {
    my $self = shift;
    my $id = shift;
    my $api_class = 'user/userinfo';
    my $post;
    
    _id_or_name(\$post, $id);
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $res->_perform;
}

sub GetTopten {
    my $self = shift;
    my $id = shift;
    my $kat = shift;
    my $api_class = 'user/topten';
    my $post;
    
    _id_or_name(\$post, $id);
    $post->{kat} = $kat;
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $res->_perform;
}

sub GetList {
    my $self = shift;
    my $post = {@_};
    my $api_class = 'user/list';
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $res->_perform;
}

sub GetLatestComment {
    my $self = shift;
    my $api_class = 'user/comments';
    my $post = {@_};
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $res->_perform;
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
