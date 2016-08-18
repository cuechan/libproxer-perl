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

package Proxer::Info;
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
use Proxer::API::Request
use Carp;
use JSON;
use Data::Dumper;
use utf8;



###########################
#                         #
#         Methods         #
#                         #
###########################

sub GetEntry {
    my $self = shift;
    my $id   = shift;
    my $api_class  = "info/entry";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data => {id => $id},
    );
    
    $req->_perform(); #perform the request
    
    return $req;
}

sub GetNames {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/names";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => {id => $id},
    );

    return $req->_perform;
}

sub GetGate {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/gate";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => {id => $id},
    );

    return $req->_perform
}

sub GetLang {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/lang";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => {id => $id},
    );

    return $req->_perform;
}

sub GetSeason {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/season";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => {id => $id},
    );

    return $req->_perform;
}

sub GetGroups {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/groups";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => {id => $id},
    );

    return $req->_perform;
}

sub GetPublisher {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/publisher";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => {id => $id},
    );

    return $req->_perform;
}

sub GetListinfo {
    my $self = shift;
    my $api_class = "info/listinfo";
    
    # Todo: Workaround for just getting the number of entries and more magic in background
    # This maybe be an global function in Proxer
    
    my $id = shift;
    my $page = shift;
    my $limit = shift;
    
    my $post = {id => $id};
    $post->{p} = $page if $page;
    $post->{limit} = $limit if $limit;
    
    my $data = $self->_api_access($api_class, $post);
    
    return $data;
}

sub GetComments {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/comments";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => {id => $id},
    );

    return $req->_perform;
}

sub GetRelations {
    my $self = shift;
    my $api_class = "info/relations";
    
    my $post = {@_};
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => $post,
    );

    return $req->_perform;
}

sub GetEntryTags {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/entrytags";
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => {id => $id},
    );

    return $req->_perform;
}

sub SetUserinfo {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/setuserinfo";
    
    my $stat = shift; # note | favor | finish
    
    my $req = Proxer::API::Request->new(
        $self,
        class => $api_class,
        data  => {id => $id, type => $stat},
    );

    return $req->_perform
    
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
