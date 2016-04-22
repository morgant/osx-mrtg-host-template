osx-mrtg-host-template
======================
by Morgan Aldridge <morgant@makkintosshu.com>

OVERVIEW
--------

Tobi Oetiker's [MRTG](http://oss.oetiker.ch/mrtg/) (Multi Router Traffic Grapher) is an oldie but goodie for graphing network traffic by polling SNMP devices and this script helps build MRTG configurations for OS X hosts that include more than just network interfaces, incl. CPU and memory.

REQUIREMENTS
------------

The OS X host must be running Xsnmp, specifically:

* Mac OS X 10.6 Snow Leopard or OS X 10.7 Lion: Xsnmp 1.1.0
* OS X 10.8 Mountain Lion or newer: [Xsnmp 1.2.1](https://github.com/gjasny/Xsnmp/releases/tag/v1.2.1)

USAGE
-----

More recent versions of MRTG's `cfgmaker` support the `--host-template` configuration option (see http://oss.oetiker.ch/mrtg/doc/cfgmaker.en.html#Details_on_Templates), so this script can be included as follows:

    --host-template mrtg_host_template-osx_server.pl 
    
For example, one might run the following to create an MRTG configuration file for an OS X host:

    cfgmaker --show-op-down --subdirs=HOSTNAME --host-template mrtg_host_template-osx_server.pl --output host.example.com.cfg public@host.example.com

CHANGE LOG
----------

v0.1 - Initial version (CPU load).  
v0.1.1 - Added memory usage. Different colors for CPU & memory graphs.

ACKNOWLEDGEMENTS
----------------

Development was sponsored by [Small Dog Electronics](http://www.smalldog.com/).

LICENSE
-------

Copyright (c) 2015-2016, Morgan Aldridge. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
