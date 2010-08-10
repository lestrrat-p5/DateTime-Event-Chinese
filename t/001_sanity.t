use strict;
use Test::More;
use DateTime;

my @new_years;
BEGIN
{
    @new_years = map {
        my %hash;
        @hash{qw(year month day time_zone)} = (@$_, 'UTC');
        DateTime->new(%hash);
    } (
        [ 1999, 2, 16 ],
        [ 2000, 2,  5 ],
        [ 2001, 1, 24 ],
        [ 2002, 2, 12 ],
        [ 2003, 2,  1 ],
        [ 2004, 1, 21 ],
        [ 2005, 2,  8 ],
        [ 2006, 1, 29 ],
        [ 2007, 2, 17 ],
    );

    use_ok("DateTime::Event::Chinese", 
        qw(chinese_new_years chinese_new_year_after));
}

foreach my $dt (@new_years) {
    my $dt0 = $dt - DateTime::Duration->new(days => int(rand(180)) + 1);
    my $ny  = chinese_new_year_after($dt0);
    $ny->truncate(to => 'day');

    ok($dt->compare($ny) == 0) or
        diag( "Expected " . $dt->datetime . ", but got " . $ny->datetime);
}

my $start = $new_years[0] + DateTime::Duration->new(days => -10);
my $end   = $new_years[$#new_years] + DateTime::Duration->new(days => 10);

my $ny   = chinese_new_years();
my $dt   = $ny->next($start);
my $idx  = 0;
while($dt < $end) {
    my $x = $dt->clone->truncate(to => 'day');
    ok($x->compare($new_years[$idx++]) == 0, "$x <-> $new_years[$idx - 1]");
    $dt = $ny->next($dt);
}  

done_testing();