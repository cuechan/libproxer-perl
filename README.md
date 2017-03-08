#libproxer2-perl
##A perl module for proxer.me
Documentation is in progress...

#Usage
The best simplest way to use this module is to `use lib`.
For this method your file structure must look like this:

```
.
├── my-script.pl
└── Proxer/
    ├── Proxer
    │   └── Info.pm
    ├── Proxer.pm
    └── README.md
```

In `my-script.pl` you can write:
```Perl
[...]
use lib 'Proxer/' # include 'Proxer/' as a module search path.
use Proxer;       # use Proxer in this script
[...]
```
# Name

Module for interaction with proxer.me;

# Synopsis

todo: Synopsis

# Functions

## new

Create a proxer object

my $prxr = Proxer->new(key => $api\_key);

If you want to load the API-key from a file:

my $prxr = Proxer->new(keyfile => 'path/to/api.key');

You also can load the key from a remote location using http or ftp:

\# NOT SUPPORTED YET!
\#my $prxr = Proxer->new(keylocation => 'http://keys.proxer.me/mykey');

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
