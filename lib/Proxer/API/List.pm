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

use lib '../..'; # only for development reason.

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

use Proxer::API::Access;
use Carp;
use Data::Dumper;


=head1 Synopsis

In-code documentations are strange... but i think otherwise i would forget to update the docs. So, lets start :D

    use Proxer::API::List;
    
    # preferred method:
    $prxr_list = $prxr->List();
    
    # or:
    $list_class = Proxer::API::List->new($existing_proxerAPI_object);
    
    $api_res = $prxr_list->GetListEntry();
    $api_res = $prxr_list->EntrySearch("One Piece");
    
    # See Proxer::API for response methods


=head1 Construction

Since C<Proxer::API> is holding our http related stuff we need an existing C<Proxer::API> object to create a new list object.

    $prxr_list = $prxr->List();
    
or

    $prxr_list = Proxer::API::List->new($prxr);

The two variants are doing technically the same. Its up to which one you want to use.
An other B<not recommended> way is this:

    $res = $prxr->List->GetEntryList();

This will work fine but it calls C<Proxer::API::List->new> every time you use it like this.
Cause of performance reasons i recommend the first two variants.

=cut


sub new {
    my $class = shift;
    my $self->{Proxer_API} = shift;
    
    return bless($self, $class);
}

sub _proxer_api {
    my $self = shift;
    
    return $self->{Proxer_API};
}
=head1 Methods

Lot of usefull methods!

=cut



###################
#                 #
#     METHODS     #
#                 #
###################





=head2 GetEntryList

=cut

sub GetEntryList {
    my $self      = shift;
    my $api_class = 'list/entrylist';
    my $post      = {@_};

    return Proxer::API::Access->new(
        Proxer_API  => $self->_proxer_api,
        scrollable  => 1,
        api_class   => $api_class,
        post_data   => $post
    );
}



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

=cut


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
        'length-limit'   => '',
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

    my $req = Proxer::API::Access->new(
        $self,
        class => $api_class,
        data  => $post,
    );

    return $req->_perform;

}

=head2 GetTagIDs

=cut

sub GetTagIDs {
    my $self      = shift;
    my $api_class = 'list/tagids';
    my $taglist   = shift;

    my $req = Proxer::API::Access->new(
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

    my $req = Proxer::API::Access->new(
        $self,
        class => $api_class,
        data  => $filter,
    );

    return $req->_perform;
}

1;



# Doc for the methods


=head2 GetEntryList



=cut
