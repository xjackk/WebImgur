# WebImgur

The power of Perl to upload pictures to Imgur!

## Useage

New up an instance of Web::Imgur.

`my $clientID = "YOUR ID HERE";`

`my $imgur = new Web::Imgur(clientID => $clientID);`

Upload a local file on disk

`$imgur->upload("/Users/jackkillilea/Downloads/bmwe30m3.jpg")`

This will on success, will return the Imgur image link!

Upload a picture from the web

`$imgur->upload("http://roa.h-cdn.co/assets/15/27/980x490/landscape-1435681410-m3.jpg")`

## For Later..

Will consider adding OAuth support for associating image uploads with your Imgur account. For now, this is just a fix of the old Image::Imgur module from 2010.
