use Test::More;
use strict;

#use lib '/home/xjackk/hacking/scripts/WebImgur/lib/';
use lib '/Users/jackkillilea/hacking/scripts/WebImgur/lib/';

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Image-Imgur.t'


BEGIN { use_ok('Web::Imgur') };

## Testing Vars
## Using my test account. Feel free to use.
my $clientID = "baf4231de7fd38e";

my $imgur = new Web::Imgur(clientID => $clientID);
ok($imgur);

my $picUpload = $imgur->upload('/Users/jackkillilea/Downloads/bmwe30m3.jpg');
print "\n"; # testing readability
ok($picUpload);

my $onlinePicUpload = $imgur->upload("http://roa.h-cdn.co/assets/15/27/980x490/landscape-1435681410-m3.jpg");
print "\n";
ok($onlinePicUpload);

done_testing();

