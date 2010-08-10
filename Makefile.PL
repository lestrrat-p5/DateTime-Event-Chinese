use inc::Module::Install;

name 'DateTime-Event-Chinese';
all_from 'lib/DateTime/Event/Chinese.pm';
requires 'DateTime::Astro';

author_tests 'xt';

WriteAll;