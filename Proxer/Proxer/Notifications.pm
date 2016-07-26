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

use JSON;
use Data::Dumper;
use utf8;

my $_Proxer;

sub new {

# Finally here's the code:
    #~ print Dumper(@_);
    #~ exit;
    #
    # We need to return a blessed reference to our main packahe (Proxer) 
    # for using the functions in it. Especially the LWP object and the _api_connect function.
    
    my $self = shift;
    my $opt  = shift;
    
    return bless({Proxer => $opt}, $self);
}

sub GetNews {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    
    my $url  = "https://proxer.me/api/v1/notifications/news";
    
    my $data = $Proxer->_api_access($url, undef);
    return $data;
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


