#!/usr/bin/env perl
#
# MRTG cfgmaker template for OS X servers (CPU, load avg, memory, etc.)
# see <http://oss.oetiker.ch/mrtg/doc/cfgmaker.en.html#Details_on_Templates>
# 
# v0.1   2015-12-30 - Morgan Aldridge <morgant@makkintosshu.com>
#                     Initial version (CPU load).
# v0.1.1 2016-01-20 - Morgan Aldridge
#                     Added memory usage. Different colors for CPU & memory
#                     graphs.
# 

# sometimes we manually run this template stand-alone (either for testing or when a cfg has already been generated), so fill in variables from args instead
# ./mrtg_host_template-osx_server.pl <community@router>
if ( ($ENV{'MANUAL_RUN'}) && (@ARGV == 1) && ($ARGV[0] =~ /^.+@(.+)$/) ) {
	$router_connect = $ARGV[0];
	$router_name = $1;
}

## CPU LOAD ####################################################################

# snmpwalk the host to determine how many CPUs it has (we'll be configuring them in pairs as MRTG only supports two measurements per interface)
if ($router_connect =~ /^(.+)@.+$/) {
	$community = $1;
}
if ( my @processors = qx"snmpwalk -v2c -c$community $router_name hrProcessorLoad" ) {
	for (my $i=0; $i < @processors; $i+=2) {
		my $n = $i + 1;
		my $hrProcessorLoad1 = 768 + $i;
		my $hrProcessorLoad2 = 768 + $n;
		
		$head_lines .= <<ECHO;
#---------------------------------------------------------------------
ECHO
		
		my $target_name = "${router_name}_cpu${i}-${n}";
		
		$target_lines .= <<ECHO;

LoadMIBs: /usr/share/snmp/mibs/HOST-RESOURCES-MIB.txt

Target[$target_name]: hrProcessorLoad.${hrProcessorLoad1}&hrProcessorLoad.${hrProcessorLoad2}:$router_connect
Directory[$target_name]: $router_name
MaxBytes[$target_name]: 100
Title[$target_name]: CPU Load (CPU$i & CPU$n) -- $router_name
#Unscaled[$target_name]: ymwd
#WithPeak[$target_name]: wmy
ShortLegend[$target_name]:  %
YLegend[$target_name]: % CPU Utilization
Legend1[$target_name]: Active CPU$i in % (Load)
Legend2[$target_name]: Active CPU$n in % (Load)
LegendI[$target_name]:  CPU$i
LegendO[$target_name]:  CPU$n
Options[$target_name]: growright, gauge, nopercent
Colours[$target_name]: ORANGE#ffa000,RED#f00000,BLACK#000000,VIOLET#ff00ff
PageTop[$target_name]: <h1>CPU Load (CPU$i & CPU$n) -- $router_name</h1>
                <div id="sysdetails">
                        <table> 
                                <tr>
                                        <td>System:</td>
                                        <td>$router_name in $html_syslocation</td>
                                </tr>
                                <tr>
                                        <td>Maintainer:</td>
                                        <td>$html_syscontact</td>
                                </tr>
                                <tr>
                                        <td>Description:</td>
                                        <td>$html_sysdescr</td>
                                </tr>
                                <tr>
                                        <td>Resource:</td>
                                        <td>CPU Load (CPU$i & CPU$n)</td>
                                </tr>
                        </table>
                </div>


ECHO

	}
}

## MEMORY USAGE ################################################################

$head_lines .= <<ECHO;
#---------------------------------------------------------------------
ECHO
		
my $target_name = "${router_name}_real_memory";
		
$target_lines .= <<ECHO;

LoadMIBs: /usr/share/snmp/mibs/UCD-SNMP-MIB.txt

Target[$target_name]: memAvailReal.0&memTotalReal.0:$router_connect
Directory[$target_name]: $router_name
MaxBytes[$target_name]: 4294967296
Title[$target_name]: Memory (Real) -- $router_name
#Unscaled[$target_name]: ymwd
#WithPeak[$target_name]: wmy
kMG[$target_name]: k,M,G,T,P
kilo[$target_name]: 1024
#ShortLegend[$target_name]:  
YLegend[$target_name]: Memory (Real)
Legend1[$target_name]: Available Memory (Real)
Legend2[$target_name]: Total Memory (Real)
LegendI[$target_name]:  Available (Real)
LegendO[$target_name]:  Total (Real)
Options[$target_name]: growright, gauge, nopercent
Colours[$target_name]: LIGHTBLUE#9090ff,RED#f00000,BLACK#000000,VIOLET#ff00ff
PageTop[$target_name]: <h1>Memory (Real) -- $router_name</h1>
                <div id="sysdetails">
                        <table> 
                                <tr>
                                        <td>System:</td>
                                        <td>$router_name in $html_syslocation</td>
                                </tr>
                                <tr>
                                        <td>Maintainer:</td>
                                        <td>$html_syscontact</td>
                                </tr>
                                <tr>
                                        <td>Description:</td>
                                        <td>$html_sysdescr</td>
                                </tr>
                                <tr>
                                        <td>Resource:</td>
                                        <td>Memory (Real)</td>
                                </tr>
                        </table>
                </div>


ECHO

my $target_name = "${router_name}_swap_memory";
		
$target_lines .= <<ECHO;

Target[$target_name]: memAvailSwap.0&memTotalSwap.0:$router_connect
Directory[$target_name]: $router_name
MaxBytes[$target_name]: 4294967296
Title[$target_name]: Memory (Swap) -- $router_name
#Unscaled[$target_name]: ymwd
#WithPeak[$target_name]: wmy
kMG[$target_name]: k,M,G,T,P
kilo[$target_name]: 1024
#ShortLegend[$target_name]:  
YLegend[$target_name]: Memory (Swap)
Legend1[$target_name]: Available Memory (Swap)
Legend2[$target_name]: Total Memory (Swap)
LegendI[$target_name]:  Available (Swap)
LegendO[$target_name]:  Total (Swap)
Options[$target_name]: growright, gauge, nopercent
Colours[$target_name]: LIGHTBLUE#9090ff,RED#f00000,BLACK#000000,VIOLET#ff00ff
PageTop[$target_name]: <h1>Memory (Swap) -- $router_name</h1>
                <div id="sysdetails">
                        <table> 
                                <tr>
                                        <td>System:</td>
                                        <td>$router_name in $html_syslocation</td>
                                </tr>
                                <tr>
                                        <td>Maintainer:</td>
                                        <td>$html_syscontact</td>
                                </tr>
                                <tr>
                                        <td>Description:</td>
                                        <td>$html_sysdescr</td>
                                </tr>
                                <tr>
                                        <td>Resource:</td>
                                        <td>Memory (Swap)</td>
                                </tr>
                        </table>
                </div>


ECHO


if ($ENV{'MANUAL_RUN'}) {
	print $head_lines;
	print $target_lines;
}
