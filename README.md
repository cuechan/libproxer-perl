# Name

Module for interaction with proxer.me;

# Synopsis

todo: Synopsis

# Functions

## new

Create a proxer object

    my $prxr = Proxer->new(key => $api_key);

If you want to load the API-key from a file:

    my $prxr = Proxer->new(keyfile => 'path/to/api.key');

You also can load the key from a remote location using http or ftp:

    # NOT SUPPORTED YET!
    #my $prxr = Proxer->new(keylocation => 'http://keys.proxer.me/mykey');

# Functions

## Info

Every api call that takes more than one argument/parameter is called with a hash:

    $prxr->info_get_entry(45); # one arg, no need for a has

    $prxr->info_get_comments({id => 45, p => 1}); # hash needed to declare the page

This guarantees a 1:1 mapping against the actual API.
There will be some wrappers to make the usage of this lib easier.

### info\_get\_full\_entry()

[Proxer Wiki](https://proxer.me/wiki/Proxer_API/v1/Info#Get_Full_Entry)

### info\_get\_entry()

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Entry)

### info\_get\_entry()

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Names)

### info\_get\_entry()

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Gate)

### info\_get\_entry()

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Lang)

### info\_get\_entry()

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Season)

### info\_get\_entry()

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Groups)

### info\_get\_publisher

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#get_Publisher)

### info\_get\_listinfo

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Listinfo)

### info\_get\_comments

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Comments)

### info\_get\_relations

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Relations)

### info\_get\_entrytags

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Get_Entrytags)

### info\_get\_listinfo

[Proxer Wiki](http://proxer.me/wiki/Proxer_API/v1/Info#Set_Userinfo)

## User

Stuff for user related things
