# Parse args of a proc

## method 1 

`if {[llength $args] == 1} {
    if { [string match $args -h] } {
      conn_sva_gen_help
      return
    }
  }
  if {$args == "" || [expr [llength $args]%2]!= 0} {
    puts "Error: Bad syntax."
    conn_sva_gen_help
    return -code error
  }

  set xlsSpecFile ""
  set outputSvFile ""
  set clkSignal ""
  set rstSignal ""
  set topName ""
  foreach {option val} $args {
    switch -- [string tolower $option]  {
      -xls_spec {set xlsSpecFile $val}
      -sv_out {set outputSvFile $val}
      -clk_signal {set clkSignal $val}
      -reset_signal {set rstSignal $val}
      -top {set topName $val}
      default {
                puts "Error: Bad syntax."
                conn_sva_gen_help
                return -code error
              }
    }
  }`

## method 2
`proc conformal {args} {
    for {set i 0} {$i<[llength $args]} {incr i} {
    switch -- [string tolower [lindex $args $i]] {
        -extension {
        incr i
        set extension [lindex $args $i] 
        }
        -generate_design_changes {
        set generate_design_changes "true" 
        }
        -golden_file_list {
        incr i
        set input_file_list  [open [lindex $args $i] r]
        }
        -revised_file_list {
        incr i
        set output_file_list  [open [lindex $args $i] r]
        }
        -top {
        incr i
        set top [lindex $args $i ]
        }
        -black_box_files {
        incr i
        set black_box_files [lindex $args $i ]
        }
        -h {
	     conformal_help; return
	    }
        default {
            return -code error "Error: Bad syntax. Invalid option [string tolower [lindex $args $i]]"
          }
        }
      }
`

## method 3

Use "cmdline" tcllib package

# namespace 

## declare a namespace

package provide dvg  0.1
# package require Tcl             8.6

`namespace eval defacto {
  namespace eval dvg {
    #-----------------------------------------------
    # Import procedures 
    #-----------------------------------------------
    set import_cmd_list [list ]
    foreach cmd $import_cmd_list { namespace import ::defacto::utl::$cmd }

    #-----------------------------------------------
    # Export procedures
    #-----------------------------------------------
    set export_cmd_list [list helloworld]
    foreach cmd $export_cmd_list {namespace export $cmd} 

    #-----------------------------------------------
    # Namespace Variables
    #-----------------------------------------------
    variable dict set db`
## namespace variable

Can be accessed in a namespace proc via the "variable" command word

## export namespace procedures and variable

Act as public OO methods/members

## import a namespace

namespace import defacto::dvg::*

## namespace children

Returns a list of all child namespaces that belong to the namespace namespace. If namespace is not specified, then the children are returned for the current namespace. This command returns fully-qualified names, which start with a double colon (::). If the optional pattern is given, then this command returns only the names that match the glob-style pattern. The actual pattern used is determined as follows: a pattern that starts with double colon (::) is used directly, otherwise the namespace namespace (or the fully-qualified name of the current namespace) is prepended onto the pattern. 

## namespace parent

 Returns the fully-qualified name of the parent namespace for namespace namespace. If namespace is not specified, the fully-qualified name of the current namespace's parent is returned. 

## namespace ensemble

https://wiki.tcl-lang.org/page/Tcl+Tutorial+Lesson+31

# package

https://www.tutorialspoint.com/tcl-tk/tcl_packages.htm
Packages are used for creating reusable units of code. A package consists of a collection of files that provide specific functionality. This collection of files is identified by a package name and can have multiple versions of same files. The package can be a collection of Tcl scripts, binary library, or a combination of both.

Package uses the concept of namespace to avoid collision of variable names and procedure names.


## package provide

## package require

## pkgIndex.tcl content

Example
    '''package ifneeded uvm_dv_env_gen 0.1 [list source [file join $dir uvm_dv_env_gen.tcl]]'''

## generate pkgIndex.tcl file in package folder

in a tclsh: pkg_mkIndex -verbose <folder> <*.tcl file list>

## import a package from specific folder into a tcl script

lappend auto_path $defacto_path
package require dvg 0.1

# TCL introspection using info

- get current proc name: [info level 0]