#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my %tests = (
    '[quote]Hello, World.[/quote]' => [
      "<div class='bbcode_quote_header'>Quote:<div class='bbcode_quote_body'>Hello, World.</div></div>",
      "Hello, World.",
    ],
    '[quote=somebody]Hello, World.[/quote]' => [
      "<div class='bbcode_quote_header'>Quote from <a href='/somebody'>somebody</a>:<div class='bbcode_quote_body'>Hello, World.</div></div>",
      "Hello, World.",
    ],
    '@somebody' => [
      "<a href='/user/somebody'>\@somebody</a>",
      '@somebody',
    ],
    '@x.yz @a.bc' => [
      "<a href='/user/x.yz'>\@x.yz</a> <a href='/user/a.bc'>\@a.bc</a>",
      '@x.yz @a.bc',
    ],
    'http://duckduckgo.com/?q=@yegg' => [
        '<a class="p-link" href="http://duckduckgo.com/?q=@yegg" rel="nofollow"><i class="p-link__icn icon-external-link"></i><span class="p-link__txt">http://duckduckgo.com/?q=@yegg</span></a>',
        'http://duckduckgo.com/?q=@yegg'
    ],
    'foo@example.com' => [
        'foo@example.com',
        'foo@example.com'
    ],
    '[code=perl]my @foo;[/code]' => [
        '<div class=\'bbcode_code_header\'>Perl Code:<pre class=\'bbcode_code_body\'><code><span class="synStatement">my</span> <span class="synIdentifier">@foo</span>;'."\n".'</code></pre></div>',
        'my @foo;'
    ],
#    "I'm testing a'postroph'e's he're ''' &<>" => [
#        'I&#39;m testing a&#39;postroph&#39;e&#39;s he&#39;re &#39;&#39;&#39; &amp;&lt;&gt;',
#        "I'm testing a'postroph'e's he're ''' &<>",
#    ],
);

use DDGC;
my $ddgc = DDGC->new;

my $counter = 0;
for my $bbcode (keys %tests) {
  my $results = $tests{$bbcode};
  is $ddgc->markup->html($bbcode), $results->[0], "bbcode parse #$counter";
  is $ddgc->markup->plain($bbcode), $results->[1], "bbcode strip #$counter";
  $counter++;
}

done_testing;
