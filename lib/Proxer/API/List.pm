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

package Proxer::API::List;
use strict;
use warnings;

require v5.6.0;
our $VERSION = 0.01;
use Exporter 'import';
our @EXPORT = qw(
  EntrySearch
  GetEntryList
  GetTagIDs
  GetTags
);

use lib '..';
use Proxer::API::Request;
use Carp;
use Data::Dumper;

###########################
#                         #
#         Methods         #
#                         #
###########################

sub EntrySearch {
    my $self      = shift;
    my $api_class = 'list/entrysearch';
    my $args      = {@_};

    my $search = {
        name             => '',
        language         => '',
        type             => '',
        genre            => [],
        nogenre          => [],
        fsk              => [],
        sort             => '',
        length           => '',
        'length-linit'   => '',
        tags             => [],
        notags           => [],
        tagratefilter    => '',
        tagspoilerfilter => '',
    };

    # convert arrays to strings
    my $post;
    foreach ( keys %$args ) {
        if ( ref( $args->{$_} ) eq 'ARRAY' ) {
            $post->{$_} = join( '+', @{ $args->{$_} } );
        }
        else {
            $post->{$_} = $args->{$_};
        }
    }

    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => $post,
    );

    return $req->_perform;

}

sub GetEntryList {
    my $self      = shift;
    my $api_class = 'list/entrylist';
    my $post      = {@_};

    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => $post,
    );
    return $req->_perform;
}

sub GetTagIDs {
    my $self      = shift;
    my $api_class = 'list/tagids';
    my $taglist   = shift;

    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => { search => $taglist },
    );

    return $req->_perform;
}

sub GetTags {
    my $self      = shift;
    my $api_class = 'list/tags';
    my $filter    = shift;

    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => $filter,
    );

    return $req->_perform;
}

1;

__DATA__

Here is the Documentation:


=head1 Name

Proxer::List

=head1 Methods

=head2 EntrySearch

    $prxrlist->EntrySearch($filter, $page, $limit);

example for $filter: 

    $filter = {
        name => 'Piece',
        language => 'de',
        type => 'animeseries',
        genre => [
            'action',
            'dram',
            'fantasy'
        ],
        nogenre => [
            'romance'
        ],
        fsk => [
            'fsk6',
            'violence'
        ],
        sort => 'clicks',
        length => '',
        'length-linit' => '',
        tags => [
            222,
            325,
            176
        ],
        notags => [
            34,
            85
        ],
    }
    
All options are equivalent to the options mentioned in the L<wiki|http://proxer.me/wiki/Proxer_API/v1/List#Entry_Search>.

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/List#Entry_Search>

=head2 GetEntryList



=cut