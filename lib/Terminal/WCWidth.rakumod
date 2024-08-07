use Terminal::WCWidth::Tables;

my sub bisearch($ucs, @table) {
    my $lower = 0;
    my $upper = @table.elems - 1;
    return False if $ucs < @table[0][0] || $ucs > @table[$upper][1];

    while $upper >= $lower {
        my $mid = ($lower + $upper) +> 1;
        if $ucs > @table[$mid][1] {
            $lower = $mid + 1;
        }
        elsif $ucs < @table[$mid][0] {
            $upper = $mid - 1;
        }
        else {
            return True;
        }
    }
    False
}

my sub wcwidth(Int:D $ucs) is export {
    ($ucs == 0 | 0x034F | 0x2028 | 0x2029)
      || 0x200B <= $ucs <= 0x200F
      || 0x202A <= $ucs <= 0x202E
      || 0x2060 <= $ucs <= 0x2063
      ?? 0
      !! $ucs < 32 || 0x07f <= $ucs < 0x0A0
        ?? -1
        !! bisearch($ucs, ZERO_WIDTH)
          ?? 0
          !! bisearch($ucs, WIDE_EASTASIAN)
            ?? 2
            !! 1
}

my sub wcswidth($str) is export {
    my $res = 0;
    for $str.NFC {
        my $w = wcwidth($_);
        return -1 if $w < 0;
        $res += $w;
    }
    $res
}

=begin pod

=head1 NAME

Terminal::WCWidth - returns character width on a terminal

=head1 SYNOPSIS

=begin code :lang<raku>

use Terminal::WCWidth;

sub print-right-aligned($s) {
    print " " x (80 - wcswidth($s));
    say $s;
}
print-right-aligned("this is right-aligned");
print-right-aligned("another right-aligned string")

=end code

=head1 DESCRIPTION

A Raku port of a L<Python module|https://github.com/jquast/wcwidth>.

=head1 SUBROUTINES

=head2 C<wcwidth>

Takes a single I<codepoint> and outputs its width:

=begin code :lang<raku>

wcwidth(0x3042) # "あ" - returns 2

=end code

Returns:

=item C<-1> for a control character
=item C<0> for a character that does not advance the cursor (NULL or combining)
=item C<1> for most characters
=item C<2> for full width characters

=head2 C<wcswidth>

Takes a I<string> and outputs its total width:

=begin code :lang<raku>

wcswidth("*ウルヰ*") # returns 8 = 2 + 6

=end code

Returns -1 if any control characters are found.

Unlike the Python version, this module does not support getting the
width of only the first C<n> characters of a string, as you can use
the C<.substr> method.

=head1 ACKNOWLEDGEMENTS

Thanks to Jeff Quast (jquast), the author of the Python module, which
in turn is based on the C library by Markus Kuhn.

=head1 AUTHORS

=item +merlan #flirora
=item José Joaquín Atria
=item Raku Community

=head1 COPYRIGHT AND LICENSE

Copyright 2015 - 2017 +merlan #flirora

Copyright 2020, 2024 Raku Commuity

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
