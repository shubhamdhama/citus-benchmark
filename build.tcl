#!/bin/tclsh
puts "SETTING CONFIGURATION"
global complete
proc wait_to_complete {} {
global complete
set complete [vucomplete]
if {!$complete} { after 5000 wait_to_complete } else { exit }
}
customscript "hammer-schema-build.tcl"
vuset vu 400
vuset timestamps 1
vuset unique 1
vuset delay 20
vuset repeat 1
vurun
wait_to_complete
vwait forever
