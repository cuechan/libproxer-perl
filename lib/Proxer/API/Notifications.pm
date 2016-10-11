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

package Proxer::API::Notifications;
use strict;
use warnings;

require v5.6.0;
our $VERSION = 0.01;
use Exporter 'import';
our @EXPORT = qw(
    Delete
    GetCount
    GetNews
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

sub GetCount {
    my $self = shift;
    my $api_class  = "notifications/count";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class
    );
    
    return $req->_perform;
}

sub GetNews {
    my $self = shift;
    my $api_class  = "notifications/news";
    my $post = {@_};
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => $post
    );
    
    return $req->_perform;
}

sub Delete {
    my $self = shift;
    my $api_class = 'notifications/delete';
    my $id = shift;
    
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => {nid => $id}
    );
    
    return $req->_perform;    
}


1;

__DATA__

Here is the Documentation:


=head1 Name

Proxer::Notifications

=head1 Constructor

Proxer::Notifications can be accessed directly or via an existing `Proxer` object.
`%options` are the same options like in the `Proxer` Constructor.

Direct access:

    use Proxer::Notifications;
    
    my $prxr_notify = Proxer::Notifications->new(%options);
    
Access via `Proxer`:

    my $prxr_notify = $prxr->notifications();

When you are using the direct way, `Proxer->new()` is called 
internally. Do this only when you just need one specific function. 
Avoid in bigger scripts.


=head1 Methods

=head2 GetCount

    $prxr_notify->GetCount();

View [Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Notifications)

=head2 GetNews

Fetching the latest news.

    $prxr_notify->GetNews($page, $limit);

View [Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Notifications)

=head2 GetNews

Delete a notification by ID.

    $prxr_notify->Delete($nid);

View [Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Notifications)

=cut
