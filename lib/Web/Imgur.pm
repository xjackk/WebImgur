#!/usr/bin/perl -w
package Web::Imgur;

## Web::Imgur - A quick reissue of Image::Imgur
## Uploads pictures anonymously to Imgur.
## Author : jrK (jaaacckz1@gmail.com)
## jackkillilea.com

use LWP;
use JSON;
use Moose; # adds warnings and strict.
use MIME::Base64;

has 'clientID' => (is => 'rw', isa => 'Str');
has 'clientSec' => (is => 'rw', isa => 'Str');

##
## Does an Anonymous upload to imgur. Post will not
## be attached to your account. (Could consider adding OAuth features...)
##
sub upload {
	(my $self, my $picture) = @_;
	return 0 unless($self->clientID);
	my $link;
	if ($picture =~ /http:\/\//) {
		$link = $picture;
	} elsif ($picture =~ /https:\/\//) {
		$link = $picture;
	}
	else {
		open my $fh, "<", $picture or return -1;
		$link = readfile($picture);
	}
	$link = $self->uploadImageAnon($link);
	return $link;
}

##
## Image Upload Helper
##
sub uploadImageAnon {
	(my $self, my $picture) = @_;
	my $ua = LWP::UserAgent->new(agent => "Perl");
	my $cID = $self->clientID(); # Moose saves our Client ID!
	my $req = $ua->post("https://api.imgur.com/3/image", ["image" => $picture], 'Authorization' => "Client-ID $cID");
	if ($req->is_success) {
		my $message = $req->decoded_content;
		my $json = from_json($message);
		return $json->{"data"}{"link"};
	} else {
		print STDERR "HTTP POST error code: ", $req->code, "\n";
		print STDERR "HTTP POST error message: ", $req->message, "\n";
		return undef;
	}
}

##
## Reads our local file for upload.
##
sub readfile {
	my $filename = shift;
	my $fh;
	open $fh, "<", $filename or return -1;
	binmode $fh;
	return encode_base64(join("" => <$fh>));
}


1;


