#!/usr/bin/perl

#--------------------------------------------------------------------------------#
# MIT License                                                                    #
#                                                                                #
# Copyright (c) 2017 paul Maruhn <paul@0x000.net>.                               #
#                                                                                #
# Permission is hereby granted, free of charge, to any person obtaining a copy   #
# of this software and associated documentation files (the "Software"), to deal  #
# in the Software without restriction, including without limitation the rights   #
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      #
# copies of the Software, and to permit persons to whom the Software is          #
# furnished to do so, subject to the following conditions:                       #
#                                                                                #
# The above copyright notice and this permission notice shall be included in all #
# copies or substantial portions of the Software.                                #
#                                                                                #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  #
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  #
# SOFTWARE.                                                                      #
#--------------------------------------------------------------------------------#


package Proxer::API;
use strict;
use warnings;

require v5.6.0;
our $VERSION = '0.01/dev';

use Carp;
use LWP;
use LWP::UserAgent;
use HTTP::Headers;
use HTTP::Request::Common;
use HTTP::Response;
use Data::Dumper;
use JSON::XS;
use Proxer::API::Access;


=head1 Name

Module for interaction with proxer.me;

=head1 Synopsis

    my $prxr = Proxer::API->new(api_key => $my_own_api_key);

    my $anime = $prxr->info_get_full_entry(53);
    print "name: ", $anime->{name};




=head1 Functions

=head2 Constructor

=head3 new

Create a proxer object

    my $prxr = Proxer->new(key => $api_key);

If you want to load the API-key from a file:

    my $prxr = Proxer->new(keyfile => 'path/to/api.key');

You also can load the key from a remote location using http or ftp:

    # NOT SUPPORTED YET!
    #my $prxr = Proxer->new(keylocation => 'http://keys.proxer.me/mykey');

=cut


sub new {
    my $self = shift;
    my $opt  = {@_};
    my $api_key;

    if ( $opt->{key} ) {
        $api_key = $opt->{key};
    }
    elsif ( $opt->{keyfile} ) {
        open( FH, '<', $opt->{keyfile} )
          or die "keyfile: $opt->{keyfile} not found on disk";
        my $key = <FH>;
        close(FH);
        chop($key);

        $api_key = $key;
    }
    else {
        croak("No key defined");
        return undef;
    }

    my $LWP = LWP::UserAgent->new();
    $LWP->agent("libproxer-perl/v0.01");
    $LWP->cookie_jar({});


    my $proxer = {
        BASE_URI => "http://proxer.me/api/v1/",
        API_KEY  => $api_key,
        LWP      => $LWP,
    };

    return bless( $proxer, $self );
}

#####################
# PRIVATE FUNCTIONS #
#####################


sub _do_request {
    my $self = shift;
    my $url = shift;
    my $data = shift // {};
    my $ua = $self->{LWP};

    $data->{api_key} = $self->{API_KEY};

    my $uri = $self->{BASE_URI}.$url;

    my $res = $ua->post($uri, $data);

    if ($res->is_error) {
        return undef;
    }
    else {
        return eval {decode_json($res->decoded_content)};
    }
}








#  ___ _  _ ___ ___
# |_ _| \| | __/ _ \
#  | || .` | _| (_) |
# |___|_|\_|_| \___/
#


=head2 Info

Every api call that takes more than one argument/parameter is called with a hash:

    $prxr->info_get_entry(45); # one arg, no need for a hash

    $prxr->info_get_comments({id => 45, p => 1}); # hash needed to declare the page

This guarantees a 1:1 mapping against the actual API.
There will be some wrappers to make the usage of this lib easier.

=cut




=head3 info_get_full_entry

L<Proxer Wiki|https://proxer.me/wiki/Proxer_API/v1/Info#Get_Full_Entry>

=cut

sub info_get_full_entry {
    my $self = shift;
    my $id   = shift;
    my $api_class  = "info/fullentry";

    return $self->_do_request($api_class, {id => $id});
}



=head3 info_get_entry

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Entry>

=cut

sub info_get_entry {
    my $self = shift;
    my $id   = shift;
    my $api_class  = "info/entry";

    return $self->_do_request($api_class, {id => $id});
}


=head3 info_get_entry

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Names>

=cut

sub info_get_names {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/names";

    return $self->_do_request($api_class, {id => $id});
}


=head3 info_get_entry

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Gate>

=cut

sub info_get_gate {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/gate";

    return $self->_do_request($api_class, {id => $id});
}



=head3 info_get_entry

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Lang>

=cut

sub info_get_lang {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/lang";

    return $self->_do_request($api_class, {id => $id});
}



=head3 info_get_entry

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Season>

=cut

sub info_get_season {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/season";

    return $self->_do_request($api_class, {id => $id});
}



=head3 info_get_entry

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Groups>

=cut

sub info_get_groups {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/groups";

    return $self->_do_request($api_class, {id => $id});
}



=head3 info_get_publisher

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#get_Publisher>

=cut

sub info_get_publisher {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/publisher";

    return $self->_do_request($api_class, {id => $id});
}




=head3 info_get_listinfo

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Listinfo>

=cut

sub info_get_listinfo {
    my $self = shift;
    my $api_class = "info/listinfo";
    my $post = {@_};

    return $self->_do_request($api_class, $post);
}




=head3 info_get_comments

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Comments>

=cut

sub info_get_comments {
    my $self = shift;
    my $api_class = "info/comments";
    my $post = {@_};

    return $self->_do_request($api_class, $post);
}



=head3 info_get_relations

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Relations>

=cut

sub info_get_relations {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/relations";

    return $self->_do_request($api_class, {id => $id});
}



=head3 info_get_entrytags

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Get_Entrytags>

=cut

sub info_get_entrytags {
    my $self = shift;
    my $id = shift;
    my $api_class = "info/entrytags";

    return $self->_do_request($api_class, {id => $id});
}


=head3 info_get_listinfo

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/Info#Set_Userinfo>

=cut

sub info_set_userinfo {
    my $self = shift;
    my $api_class = "info/setuserinfo";
    my $post = {@_};

    return $self->_do_request($api_class, $post);
}









#  _   _ ___ ___ ___
# | | | / __| __| _ \
# | |_| \__ \ _||   /
#  \___/|___/___|_|_\
#


=head2 User

Stuff for user related things

=cut



=head3 user_login

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/User#Login>

=cut

sub user_login {
    my $self = shift;
    my $api_class = "user/login";
    my $post = {@_};

    return $self->_do_request($api_class, $post);
}



=head3 user_logout

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/User#Logout>

=cut

sub user_logout {
    my $self = shift;
    my $api_class  = "user/logout";
    my $post = {@_};

    return $self->_do_request($api_class, $post);
}




=head3 user_userinfo

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/User#Userinfo>

=cut

sub user_userinfo {
    my $self = shift;
    my $api_class = 'user/userinfo';
    my $post = {@_};

    return $self->_do_request($api_class, $post);
}






=head3 user_get_topten

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/User#Get_Topten>

=cut

sub user_gettopten {
    my $self = shift;
    my $api_class = 'user/topten';
    my $post = {@_};

    return $self->_do_request($api_class, $post);
}




=head3 user_get_list

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/User#Get_List>

=cut

sub user_getlist {
    my $self = shift;
    my $api_class = 'user/list';
    my $post = {@_};

    return $self->_do_request($api_class, $post);
}


=head3 user_get_topten

L<Proxer Wiki|http://proxer.me/wiki/Proxer_API/v1/User#Get_Latest_Comment>

=cut

sub user_get_latest_comment {
    my $self = shift;
    my $api_class = 'user/comments';
    my $post = {@_};

    return $self->_do_request($api_class, $post);
}










1;
