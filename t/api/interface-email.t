
use Test::More qw/no_plan/;
use RT;
RT::LoadConfig();
RT::Init();

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 97 lib/RT/Interface/Email.pm

ok(require RT::Interface::Email);


    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

1;
