
use Test::More qw/no_plan/;
use RT;
RT::LoadConfig();
RT::Init();

{
    undef $main::_STDOUT_;
    undef $main::_STDERR_;
#line 60 lib/RT/ScripActions_Overlay.pm

ok (require RT::ScripActions);


    undef $main::_STDOUT_;
    undef $main::_STDERR_;
}

1;
