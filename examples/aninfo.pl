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
use Data::Dumper;
use lib './lib/';
use Proxer;
use utf8;


# create the main object
my $prxr = Proxer->new();


print("Enter the proxerID of the anime: ");
my $id = <STDIN>;
chomp($id);

my $info = $prxr->anime_info($id);

#print Dumper($info);

print("Titel: ", $info->{title}, " (", $info->{id}, ")\n");
print("Season: ", $info->{season}, "\n");
print("genres: \n");

foreach(@{$info->{genre}}) {
    print("    $_\n");
}

print($info->{desc}, "\n");

$prxr->proxer();
