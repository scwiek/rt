# BEGIN BPS TAGGED BLOCK {{{
#
# COPYRIGHT:
#
# This software is Copyright (c) 1996-2020 Best Practical Solutions, LLC
#                                          <sales@bestpractical.com>
#
# (Except where explicitly superseded by other copyright notices)
#
#
# LICENSE:
#
# This work is made available to you under the terms of Version 2 of
# the GNU General Public License. A copy of that license should have
# been provided with this software, but in any event can be snarfed
# from www.gnu.org.
#
# This work is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301 or visit their web page on the internet at
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.html.
#
#
# CONTRIBUTION SUBMISSION POLICY:
#
# (The following paragraph is not intended to limit the rights granted
# to you to modify and distribute this software under the terms of
# the GNU General Public License and is only of importance to you if
# you choose to contribute your changes and enhancements to the
# community by submitting them to Best Practical Solutions, LLC.)
#
# By intentionally submitting any modifications, corrections or
# derivatives to this work, or any other work intended for use with
# Request Tracker, to Best Practical Solutions, LLC, you confirm that
# you are the copyright holder for those contributions and you grant
# Best Practical Solutions,  LLC a nonexclusive, worldwide, irrevocable,
# royalty-free, perpetual, license to use, copy, create derivative
# works based on those contributions, and sublicense and distribute
# those contributions and any derivatives thereof.
#
# END BPS TAGGED BLOCK }}}

package RT::Action::SetSLAFromPriority;
use base 'RT::Action';

use strict;
use warnings;

=head2 Prepare

=cut

sub Prepare {
    my $self = shift;
    return 0 if $self->TicketObj->QueueObj->SLADisabled;

    my $priority_to_sla = RT::Config->Get( 'PriorityToSLA' ) or return 0;
    my $sla
        = $priority_to_sla->{ $self->TicketObj->Priority } || $priority_to_sla->{ $self->TicketObj->PriorityAsString }
        or return 0;

    return 0 if ( $self->TicketObj->SLA // '' ) eq $sla;
    $self->{SLA} = $sla;
    return 1;
}

=head2 Commit

Set SLA based on Priority.

=cut

sub Commit {
    my $self = shift;

    if ( $self->{SLA} ) {
        my ($ret, $msg) = $self->TicketObj->SetSLA( $self->{SLA} );
        RT::Logger->error( "Could not set ticket SLA from priority: $msg" ) unless $ret;
        return $ret;
    }
    return 1;
}

1;