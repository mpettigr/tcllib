if {![package vsatisfies [package provide Tcl] 8.2]} {
    return
}
package ifneeded bench            0.1 [list source [file join $dir bench.tcl]]
package ifneeded bench::out::text 0.1 [list source [file join $dir bench_wtext.tcl]]
package ifneeded bench::out::csv  0.1 [list source [file join $dir bench_wcsv.tcl]]
