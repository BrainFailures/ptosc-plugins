# ptosc-plugins
Misc. plugins for pt-online-schema-change

### pause_before_swap

Hooks into before_swap_table
1. Enter endless (sleeping) loop if /tmp/pause_alter exists

This simply gives you control over *when* a table is swapped out.

Yes, I am aware of the --pause-file flag, but that pauses all execution.
