#!/usr/bin/perl

# Copyright (c) 2016 Paul Maruhn
#
# Permission is hereby granted, free of charge, to any person obtaining 
# a copy of this software and associated documentation files 
# (the "Software"), to deal in the Software without restriction, 
# including without limitation the rights to use, copy, modify, merge, 
# publish, distribute, sublicense, and/or sell copies of the Software, 
# and to permit persons to whom the Software is furnished to do so, 
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be 
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

use warnings;
use strict;
use lib './lib/';
use Proxer;
use Data::Dumper;
use POSIX qw(strftime);
use Term::ANSIColor qw(:constants);
local $Term::ANSIColor::AUTORESET = 1;


# create the main object
my $prxr = Proxer->new();

# create an user session
# ask for username and password
print("username: ");
my $username = <STDIN>;
print("password: ");
my $password = <STDIN>;

# remove the '\n' from the end
# read more at http://perldoc.perl.org/functions/chomp.html

chomp($username, $password);
my $prxruser = $prxr->session($username, $password) or die $prxr->error;


while(1) {
    my @conversations = $prxruser->fetch_conf();
    
    foreach(@conversations) {
        print BOLD CYAN ($_->{topic}, "\n");
        
        my $time = strftime('%F %T', localtime($_->{timestamp_end}));
        
        print('last message: ', $time, "\n");
        print('ID: ', BOLD $_->{id}, "\n");
        print("\n");
    }
    
    my $id;
    my @messages;
    while(1) {
        print("Enter ID to view messages: ");
        chomp($id = <STDIN>);
        
        if($id =~ m/^\d+$/) {
            @messages = $prxruser->get_msg($id, 0, 14);
            if(!@messages) {
                print("An error occured: ", $prxr->error, "\n");
                next;
            }
            last;
        }
        else {
            next;
        }
    }
    
    
    
    foreach(@messages) {
        my $time = strftime('%T', localtime($_->{timestamp}));
        print(BOLD CYAN $_->{username}, " ", RESET $time, "\n");
        
        print(">> ", $_->{message}, "\n");
        print("\n");
    }
    
    
    while(1) {
        print("[reply: r, back: b]: ");
        chomp(my $x = <STDIN>);
        if($x eq 'r') {
            chomp(my $newmessage = <STDIN>);
            $prxruser->reply_msg($id, $newmessage);
            
            my @messages = $prxruser->get_msg($id, 0, 14);
            
            foreach(@messages) {
                my $time = strftime('%T', localtime($_->{timestamp}));
                print(BOLD CYAN $_->{username}, " ", RESET $time, "\n");
                
                print(">> ", $_->{message}, "\n");
                print("\n");
            }
            next;
            
        }
        elsif($x eq 'b') {
            last;
        }
    }
    
    
    
}
