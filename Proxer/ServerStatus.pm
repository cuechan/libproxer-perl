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



our $ERROR = "no errors occured";

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
	return 1;
}



1;
