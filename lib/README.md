# Name

Module for interaction with proxer.me;

# Synopsis

todo: Synopsis 

# Functions

## new

Create a proxer object
```Perl
    my $prxr = Proxer->new(key => $api_key);
```

If you want to load the API-key from a file:
```Perl
    my $prxr = Proxer->new(keyfile => 'path/to/api.key');
```

You also can load the key from a remote location using http or ftp:
```Perl
    # NOT SUPPORTED YET!
    #my $prxr = Proxer->new(keylocation => 'http://keys.proxer.me/mykey');
```
