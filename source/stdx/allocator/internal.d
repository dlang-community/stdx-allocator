// Private parts of Phobos
module stdx.allocator.internal;

import std.traits;

// Bulk of emplace unittests ends here

static if (is(typeof({ import std.typecons : Ternary; })))
{
    public import std.typecons : Ternary;
}
else static if (is(typeof({ import std.experimental.allocator.common : Ternary;  })))
{
    public import std.experimental.allocator.common : Ternary;
}
else static assert(0, "Oops, dont know how to find Ternary");

/**
Check whether a number is an integer power of two.

Note that only positive numbers can be integer powers of two. This
function always return `false` if `x` is negative or zero.

Params:
    x = the number to test

Returns:
    `true` if `x` is an integer power of two.
*/
bool isPowerOf2(X)(const X x) pure @safe nothrow @nogc
if (isNumeric!X)
{
    static if (isFloatingPoint!X)
    {
        import std.math : frexp;
        int exp;
        const X sig = frexp(x, exp);

        return (exp != int.min) && (sig is cast(X) 0.5L);
    }
    else
    {
        static if (isSigned!X)
        {
            auto y = cast(typeof(x + 0))x;
            return y > 0 && !(y & (y - 1));
        }
        else
        {
            auto y = cast(typeof(x + 0u))x;
            return (y & -y) > (y - 1);
        }
    }
}
///
@safe unittest
{
    import std.math : pow;

    assert( isPowerOf2(1.0L));
    assert( isPowerOf2(2.0L));
    assert( isPowerOf2(0.5L));
    assert( isPowerOf2(pow(2.0L, 96)));
    assert( isPowerOf2(pow(2.0L, -77)));

    assert(!isPowerOf2(-2.0L));
    assert(!isPowerOf2(-0.5L));
    assert(!isPowerOf2(0.0L));
    assert(!isPowerOf2(4.315));
    assert(!isPowerOf2(1.0L / 3.0L));

    assert(!isPowerOf2(real.nan));
    assert(!isPowerOf2(real.infinity));
}
///
@safe unittest
{
    assert( isPowerOf2(1));
    assert( isPowerOf2(2));
    assert( isPowerOf2(1uL << 63));

    assert(!isPowerOf2(-4));
    assert(!isPowerOf2(0));
    assert(!isPowerOf2(1337u));
}

@safe unittest
{
    import std.meta : AliasSeq;
    import std.math : pow;

    immutable smallP2 = pow(2.0L, -62);
    immutable bigP2 = pow(2.0L, 50);
    immutable smallP7 = pow(7.0L, -35);
    immutable bigP7 = pow(7.0L, 30);

    foreach (X; AliasSeq!(float, double, real))
    {
        immutable min_sub = X.min_normal * X.epsilon;

        foreach (x; [smallP2, min_sub, X.min_normal, .25L, 0.5L, 1.0L,
                              2.0L, 8.0L, pow(2.0L, X.max_exp - 1), bigP2])
        {
            assert( isPowerOf2(cast(X) x));
            assert(!isPowerOf2(cast(X)-x));
        }

        foreach (x; [0.0L, 3 * min_sub, smallP7, 0.1L, 1337.0L, bigP7, X.max, real.nan, real.infinity])
        {
            assert(!isPowerOf2(cast(X) x));
            assert(!isPowerOf2(cast(X)-x));
        }
    }

    foreach (X; AliasSeq!(byte, ubyte, short, ushort, int, uint, long, ulong))
    {
        foreach (x; [1, 2, 4, 8, (X.max >>> 1) + 1])
        {
            assert( isPowerOf2(cast(X) x));
            static if (isSigned!X)
                assert(!isPowerOf2(cast(X)-x));
        }

        foreach (x; [0, 3, 5, 13, 77, X.min, X.max])
            assert(!isPowerOf2(cast(X) x));
    }
}
