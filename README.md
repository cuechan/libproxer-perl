#libproxer2-perl
##A perl module for proxer.me 
Documentation is in progress... 

Most of the documentation is embedded as pod in the module itself.
I will convert these pod's for each class to a markdown file which can be found in the same directory.

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
