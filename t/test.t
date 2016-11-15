use Test::More;
#use lib '/home/xjackk/hacking/scripts/PerlImgur/lib/';
use lib '/Users/jackkillilea/hacking/scripts/PerlImgur/lib/';
BEGIN { use_ok('Web::Imgur') };

## Testing Vars
## Using my test account. Feel free to use.
my $clientID = "baf4231de7fd38e";
my $clientSecret = "879e010d91abd02fd0ccfc211be0f0e2b1073b69";

my $imgur = new Web::Imgur(clientID => $clientID, clientSec => $clientSecret);
ok($imgur);

my $picUpload = $imgur->upload_anon('/Users/jackkillilea/Downloads/bmwe30m3.jpg');
ok($picUpload);

my $onlinePicUpload = $imgur->upload_anon("http://roa.h-cdn.co/assets/15/27/980x490/landscape-1435681410-m3.jpg");
ok($onlinePicUpload);

done_testing();

