#!/usr/bin/perl -w
package Web::Imgur;

## Web::Imgur - A quick reissue of Image::Imgur
## Uploads pictures anonymously to Imgur.
## Author : jrK (jaaacckz1@gmail.com)
## jackkillilea.com

use LWP;
use Moose; # adds warnings and strict.
use MIME::Base64;

has 'clientID' => (is => 'rw', isa => 'Str');
has 'clientSec' => (is => 'rw', isa => 'Str');

##
## Reads the file, mmhm.
##
sub readfile {
		my $filename = shift;
		my $fh;
		open $fh, "<", $filename or return -1;
		binmode $fh;
		return encode_base64(join("" => <$fh>));
}

##
## Does an Anonymous upload to imgur. Post will not
## be attached to your account.
##
sub upload_anon {
	(my $self, my $picture) = @_;
		return 0 unless($self->clientID);
		my $link;
		if ($picture =~ /http:\/\//) {
				$link = $picture;
			} elsif ($picture =~ /https:\/\//) {
				$link = $picture;
			} else {
				open my $fh, "<", $picture or return -1;
				$link = readfile($picture);
		}
	$link = $self->uploadImageAnon($link);
	return $link;
}

##
## upload Image Anon helpery
##
sub uploadImageAnon {
	(my $self, my $picture) = @_;
	my $ua = LWP::UserAgent->new(agent => "Perl");
	my $req = $ua->post("https://api.imgur.com/3/image", ["image" => $picture], 'Authorization' => "Client-ID $self->clientID" );
	if ($req->is_success) {
		my $message = $req->decoded_content;
		my $json = from_json($message);
		print "Upload Complete! Your link is : " .  $json->{"data"}{"link"} . "\n";
	} else {
		print "HTTP POST error code: ", $req->code, "\n";
		print "HTTP POST error message: ", $req->message, "\n";
	}
}



































































































