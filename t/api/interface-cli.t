
use Test::More qw/no_plan/;
use RT;
RT::LoadConfig();
RT::Init();

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 102 lib/RT/Interface/CLI.pm

ok(require RT::Interface::CLI);


    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

1;
