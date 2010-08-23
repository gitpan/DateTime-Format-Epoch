use strict;
BEGIN { $^W = 1 }

use Test::More tests => 7;
use DateTime;
use DateTime::Format::Epoch;

my $dt = DateTime->new( year  => 1970, month => 1, day   => 1 );

my $f = DateTime::Format::Epoch->new( epoch => $dt );
my $f_float = DateTime::Format::Epoch->new( epoch => $dt, type => 'float' );

isa_ok($f, 'DateTime::Format::Epoch' );

is($f->format_datetime($dt), 0, 'Epoch = 0');

$dt->set( hour => 1 );
is($f->format_datetime($dt), 3600, 'Epoch + 1hour');

$dt->set( day => 2, hour => 0 );
is($f->format_datetime($dt), 24*3600, 'Epoch + 1day');

$dt = DateTime->new( year => 2003, month => 4, day => 27,
                     hour => 21, minute => 9, second => 57,
                     nanosecond => 8e8, time_zone => 'Europe/Amsterdam' );

is($f->format_datetime($dt), 1051470597, '"now"');
is($f_float->format_datetime($dt), 1051470597.8, '"now" (float)');

$dt = DateTime->new( year => 1969, month => 12, day => 22 );
is($f->format_datetime($dt), -10*24*3600, 'Epoch - 10days');
