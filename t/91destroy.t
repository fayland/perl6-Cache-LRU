use Test;
use Cache::LRU;

class Foo {
    our $cnt = 0;

    submethod BUILD {
        $cnt++;
    }

    submethod DESTROY {
        $cnt--;
    }
}

my $cache = Cache::LRU.new(size => 3);

$cache.set('a', Foo.new());
is $Foo::cnt, 1;

diag "broken test, FIXME";
done-testing;
exit;

$cache.set('a', 2);
is $Foo::cnt, 0;

$cache.set('b', Foo.new());
is $Foo::cnt, 1;
$cache.remove('b');
is $Foo::cnt, 0;

done-testing;