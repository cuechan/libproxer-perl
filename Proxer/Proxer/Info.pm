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
use lib '..';
#~ use Proxer;


use 5.006;
use strict;
use warnings;
our $VERSION = '0.01';

use Carp;
use JSON;
use Data::Dumper;
use utf8;


sub new {
    my $self = shift;
    my %opt = @_;
    
    if($opt{_intern}) {
        my $prxr_info;
        carp "Indirect call" if $ENV{DEBUG};
        
        $prxr_info->{Proxer} = $opt{_intern};
        $prxr_info->{Data} = 'DUMMY';
        
        return bless($prxr_info, $self);
    }
    else {
        carp "Direct call" if $ENV{DEBUG};;
        
        require Proxer;
        my $prxr = Proxer->new(@_);
        return $prxr->info();
    }
}

############################
#                          #
#     Standard Methods     #
#                          #
############################

sub _seterror {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    
    
    $Proxer->_seterror(@_);
    
    return @_;
}

sub error {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    
    return $Proxer->error(@_);
}



sub GetEntry {
    my $self = shift;
    my $Proxer = $self->{Proxer};
    my $id   = shift;
    my $api_class  = "info/entry";
    
    my $data = $Proxer->_api_access($api_class, {id => $id});
    return $data;
}

sub GetNames {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $id = shift;
    my $api_class = "info/names";
    
    my $data = $Proxer->_api_access($api_class, {id => $id});
    
    return $data;
}

sub GetGate {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $id = shift;
    my $api_class = "info/gate";
    
    my $data = $Proxer->_api_access($api_class, {id => $id});
    
    return $data;
}

sub GetLang {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $id = shift;
    my $api_class = "info/lang";
    
    my $data = $Proxer->_api_access($api_class, {id => $id});
    
    return $data;
}

sub GetSeason {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $id = shift;
    my $api_class = "info/season";
    
    my $data = $Proxer->_api_access($api_class, {id => $id});
    
    return $data;
}

sub GetGroups {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $id = shift;
    my $api_class = "info/groups";
    
    my $data = $Proxer->_api_access($api_class, {id => $id});
    
    return $data;
}

sub GetPublisher {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $id = shift;
    my $api_class = "info/publisher";
    
    my $data = $Proxer->_api_access($api_class, {id => $id});
    
    return $data;
}

sub GetListinfo {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $api_class = "info/listinfo";
    
    # Todo: Workaround for just getting the number of entries and more magic in background
    # This maybe be an global function in Proxer
    
    my $id = shift;
    my $page = shift;
    my $limit = shift;
    
    my $post = {id => $id};
    $post->{p} = $page if $page;
    $post->{limit} = $limit if $limit;
    
    my $data = $Proxer->_api_access($api_class, $post);
    
    return $data;
}

sub GetComments {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $id = shift;
    my $api_class = "info/comments";
    
    my $data = $Proxer->_api_access($api_class, {id => $id});
    
    return $data;
}

sub GetRelations {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $api_class = "info/relations";
    
    
    # Todo: Magic
    
    my $id = shift;
    my $page = shift;
    my $limit = shift;
    
    my $post;
    $post->{id} = $id;
    $post->{p} = $page if $page;
    $post->{limit} = $limit if $limit;
    
    my $data = $Proxer->_api_access($api_class, $post);
    
    return $data;
}

sub GetEntryTags {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $id = shift;
    my $api_class = "info/entrytags";
    
    my $data = $Proxer->_api_access($api_class, {id => $id});
    
    return $data;
}

sub SetUserinfo {
    my $self = shift;
    my $Proxer  = $self->{Proxer};
    my $id = shift;
    my $api_class = "info/setuserinfo";
    
    my $list = shift; # note | favor | finish
    
    
    my $data = $Proxer->_api_access($api_class, {id => $id, type => $list});
    
    return $data;
}

1


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
