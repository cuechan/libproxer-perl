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
