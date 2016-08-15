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

package Proxer::Notifications;

use 5.006;
use strict;
use warnings;
our $VERSION = '0.01';

use Carp;
use JSON;
use Data::Dumper;
use utf8;

my $_Proxer;

sub new {
    my $self = shift;
    my %opt = @_;
    
    carp "Proxer::Notifications Constructor called" if $ENV{DEBUG};
    
    if($opt{_intern}) {
        my $prxr_notify;
        
        $prxr_notify->{Proxer} = $opt{_intern};
        $prxr_notify->{Data} = 'DUMMY';
        
        return bless($prxr_notify, $self);
    }
    else {
        require Proxer;
        
        my $prxr = Proxer->new(%opt);
        return $prxr->notifications();
    }
}

sub error {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    
    return $Proxer->error(@_);
}


sub GetCount {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    my $api_class  = "notifications/count";
    
    my $res = $Proxer->_api_access($api_class, undef);
    
    return $res;
}

sub GetNews {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    my $api_class  = "notifications/news";
    
    my $api = $Proxer->_api_access($api_class, undef);
    return $api;
    
    
    #~ if($api->{error} != 0) {
        #~ return undef;
    #~ }
    #~ else {
        #~ my @news = @{$api->{data}};
        #~ return @news;
    #~ }
}

sub Delete {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    my $id = shift;
    my $api_class = 'notifications/delete';
    
    my $data = $Proxer->_api_access($api_class, $id);
    return $data;
    
    carp "not implemented yet";
    # TODO
    
    return 1;
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
