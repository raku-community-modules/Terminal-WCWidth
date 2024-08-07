[![Actions Status](https://github.com/raku-community-modules/Terminal-WCWidth/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/Terminal-WCWidth/actions) [![Actions Status](https://github.com/raku-community-modules/Terminal-WCWidth/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/Terminal-WCWidth/actions) [![Actions Status](https://github.com/raku-community-modules/Terminal-WCWidth/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/Terminal-WCWidth/actions)

title
=====

Terminal::WCWidth

NAME
====

Terminal::WCWidth - returns character width on a terminal

SYNOPSIS
========

```raku
use Terminal::WCWidth;

sub print-right-aligned($s) {
    print " " x (80 - wcswidth($s));
    say $s;
}
print-right-aligned("this is right-aligned");
print-right-aligned("another right-aligned string")
```

DESCRIPTION
===========

A Raku port of a Python module ([https://github.com/jquast/wcwidth](https://github.com/jquast/wcwidth))

SUBROUTINES
===========

`wcwidth`
---------

Takes a single *codepoint* and outputs its width:

```raku
wcwidth(0x3042) # "あ" - returns 2
```

Returns:

  * `-1` for a control character

  * `0` for a character that does not advance the cursor (NULL or combining)

  * `1` for most characters

  * `2` for full width characters

`wcswidth`
----------

Takes a *string* and outputs its total width:

```raku
wcswidth("*ウルヰ*") # returns 8 = 2 + 6
```

Returns -1 if any control characters are found.

Unlike the Python version, this module does not support getting the width of only the first `n` characters of a string, as you can use the `.substr` method.

ACKNOWLEDGEMENTS
================

Thanks to Jeff Quast (jquast), the author of the Python module, which in turn is based on the C library by Markus Kuhn.

AUTHORS
=======

  * Tae Lim Koo

  * José Joaquín Atria

  * Raku Community

COPYRIGHT AND LICENSE
=====================

Copyright 2015 - 2017 Tae Lim Koo

Copyright 2020, 2024 Raku Commuity

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

