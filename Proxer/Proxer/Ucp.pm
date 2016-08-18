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

package Proxer::Ucp;
use strict;
use warnings;

require v5.6.0;
our $VERSION = 0.01;
use Exporter 'import';
our @EXPORT = (
    'GetList',
    'GetListsum',
    'GetTopten',
    'GetHistory',
    'GetVotes',
    'GetReminder',
    'DeleteReminder',
    'DeleteFavorite',
    'DeleteVote',
    'SetCommentState',
    'SetReminder',
);

use lib '..';
use Proxer::API::Request;
use Carp;
use Data::Dumper;
use utf8;


###########################
#                         #
#         Methods         #
#                         #
###########################

sub GetList {
    my $self = shift;
    my $api_class  = "ucp/list";
    my $post = {@_};
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $res->_perform;
}

sub GetListsum {
    my $self = shift;
    my $api_class  = "ucp/listsum";
    my $kat = shift;
    my $post = {@_};
    
    $post->{kat} = $kat if $kat;
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $res->_perform;
}

sub GetTopten {
    my $self = shift;
    my $api_class  = "ucp/topten";
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
    );
    
    return $res->_perform;
}

sub GetHistory {
    my $self = shift;
    my $api_class  = "ucp/history";
    my $post = {@_};
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $res->_perform;
}

sub GetVotes {
    my $self = shift;
    my $api_class  = "ucp/votes";
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
    );
    
    return $res->_perform;
}

sub GetReminder {
    my $self = shift;
    my $api_class  = "ucp/reminder";
    my $post = {@_};
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $res->_perform;
}

sub DeleteReminder {
    my $self = shift;
    my $api_class  = "ucp/deletereminder";
    my $id = shift;
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => {id => $id}
    );
    
    return $res->_perform;
}

sub DeleteFavorite {
    my $self = shift;
    my $api_class  = "ucp/deletefavorite";
    my $id = shift;
    
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => {id => $id}
    );
    
    return $res->_perform;
}

sub SetCommentState {
    my $self = shift;
    my $api_class  = "ucp/setcommentstate";
    my $id = shift;
    my $state = shift;
        
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => {id => $id, value => $state}
    );
    
    return $res->_perform;
}

sub SetReminder {
    my $self = shift;
    my $api_class  = "ucp/setreminder";
    my $post = {@_};
    
    my $res = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $res->_perform;
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
