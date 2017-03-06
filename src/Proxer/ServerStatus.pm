#!/usr/bin/perl


#--------------------------------------------------------------------------------#
# MIT License                                                                    #
#                                                                                #
# Copyright (c) 2016 paul Maruhn <paul@0x000.net>.                               #
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
#
#
# This is a module that checks the server status from proxer.
# It uses the json API from proxer.de
# 


package Proxer::ServerStatus;

use warnings;
use strict;
use Data::Dumper;
use JSON;
use LWP::UserAgent;

use Exporter 'import';
our @EXPORT_OK = qw(
	check_server_status
	
);
our %EXPORT_TAGS = (
    'all' => [@EXPORT_OK]
);



=head1 Name

Proxer::ServerStatus

=head1 Synosis
	
	use Proxer::ServerStatus qw(check_server_status); # import the required function into our namespace
	
	my $proxerstatus = check_server_status() or die "cant check server status: ", $Proxer::ServerStatus::ERROR;
	foreach( keys %$proxerstatus ) {
		print $_;
		
		if( !$proxerstatus->{$_} ) {
			print " is down\n";
		}
		else {
			print " is up\n";
		}
	}

=cut


=head1 Varibles and errorhandling

There actually only one exported variable C<$Proxer::ServerStatus::ERROR>.

This variable stores the most recent error message.

	$status = check_server_status() or die $Proxer::ServerStatus::ERROR;
	
This code exits and prints the error message when the check failed

=cut

our $ERROR = "no errors occured";


=head1 functions

All necessary functions need to be imported (see synopsis)

=cut


sub check_server_status {
	my $LWP = LWP::UserAgent->new("libproxer-serverstatus-perl/perl5");
	$LWP->timeout(5);
	my $url = "http://proxer.de/status_json.php";
	
	
	my $proxerstatus_raw = $LWP->get($url);
	
	if( $proxerstatus_raw->is_error ) {
		$ERROR = "GETting $url failed: ".$proxerstatus_raw->status_line;
		return undef;
	}
	else {
		my $proxerstatus_json = $proxerstatus_raw->decoded_content;
		my $proxerstatus = decode_json($proxerstatus_json);
		
		
		
		foreach( keys %$proxerstatus ) {
			$proxerstatus->{$_} = $proxerstatus->{$_} != 0 ? 1 : undef;
		}
		
		return $proxerstatus;
	}

=head2 check_server_status

Checks the current server status using proxer.de API.

It returns a heshref similar like this:

	$VAR1 = {
		'helper' => 1,
		'stream_44' => 1,
		'stream_37' => undef,
		'stream_43' => 1,
		'stream_30' => 1,
		'stream_41' => 1,
		'stream_50' => 1,
		'teamspeak' => 1,
		'manga_1' => 1,
		'manga_5' => 1,
		'manga_4' => 1,
		'stream_39' => 1,
		'cdn' => 1,
		'stream_38' => 1,
		'stream_45' => 1,
		'stream_27' => 1,
		'stream_47' => 1,
		'manga_3' => 1,
		'stream_36' => 1,
		'stream_48' => 1,
		'stream_14' => 1,
		'manga_0' => 1,
		'stream_40' => 1,
		'manga_2' => 1,
		'mysql' => 1,
		'stream_46' => 1,
		'stream_49' => 1,
		'stream' => 1,
		'project_t' => 1,
		'web' => 1,
		'stream_42' => 1,
		'stream_3' => 1
	};

As you can see the server status is C<1> when its online otherwise it will be C<undef>.

=cut

	return 1;
	
}

sub check_api_status {
	my $api_key = shift;
	
	
	return 1;
}



1;
