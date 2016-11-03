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

package Proxer::API::Info;
use strict;
use warnings;

require v5.6.0;
our $VERSION = 0.01;
use Exporter 'import';
our @EXPORT = qw(
    GetEntry
    GetNames
    GetGate
    GetLang
    GetSeason
    GetGroups
    GetPublisher
    GetListinfo
    GetComments
    GetRelations
    GetEntryTags
    SetUserinfo
);

use lib '..';
use Proxer::API::Access;
use Carp;
use JSON::XS;
use Data::Dumper;
use utf8;




sub new {
    my $class = shift;
    my $self->{Proxer_API} = shift;

    return bless($self, $class);
}

sub _proxer_api {
    my $self = shift;

    return $self->{Proxer_API};
}



###########################
#                         #
#         Methods         #
#                         #
###########################

sub GetEntry {
    my $self = shift;
    my $id   = shift;
    my $api_class  = "info/entry";

    return Proxer::API::Access->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => {id => $id},
    );
}

sub GetNames {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/names";

    return Proxer::API::Access->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => {id => $id},
    );
}

sub GetGate {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/gate";

    return Proxer::API::Request->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => {id => $id}
    );
}

sub GetLang {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/lang";

    return Proxer::API::Request->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => {id => $id},
    );
}

sub GetSeason {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/season";

    return Proxer::API::Request->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => {id => $id},
    );
}

sub GetGroups {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/groups";

    return Proxer::API::Request->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => {id => $id},
    );
}

sub GetPublisher {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/publisher";

    return Proxer::API::Request->new(
        Proxer_API => $self->_proxer_api,
        class => $api_class,
        data  => {id => $id},
    );
}

sub GetListinfo {
    my $self = shift;
    my $api_class = "info/listinfo";
    my $post = {@_};

    return Proxer::API::Request->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => $post
    );
}

sub GetComments {
    my $self = shift;
    my $api_class = "info/comments";
    my $post = {@_};

    croak("No id given") unless $post->{id};

    return Proxer::API::Access->new(
        Proxer_API => $self->_proxer_api,
        api_class => $api_class,
        post_data => $post
    );
}

sub GetRelations {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/relations";

    return Proxer::API::Request->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => {id => $id},
    );
}

sub GetEntryTags {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/entrytags";

    return Proxer::API::Request->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => {id => $id},
    );
}

sub SetUserinfo {
    my $self = shift;
    my $id = shift;
    my $stat = shift; # note | favor | finish
    my $api_class = "info/setuserinfo";


    return Proxer::API::Request->new(
        Proxer_API => $self->_proxer_api,
        api_class  => $api_class,
        post_data  => {id => $id, type => $stat},
    );
}

1;


__DATA__

Here is the Documentation:


=head1 Name

Proxer::Info

=head1 Functions

=head2 GetEntry

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Get_Entry>

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

=head2 GetNames

Todo...

    $prxrinfo->GetNames($id);

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Names>

=head2 GetGate

Todo...

    $prxrinfo->GetGate($id);

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Gate>

=head2 GetLang

Todo...

    $prxrinfo->GetLang($id);

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Lang>

=head2 GetSeason

Todo...

    $prxrinfo->GetSeason($id);

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Season>

=head2 GetGroups

Todo...

    $prxrinfo->GetGroups($id);

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Groups>

=head2 GetListinfo

    $prxrinfo->GetListinfo($id, $page, $limit);

More at L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Listinfo>

=cut
