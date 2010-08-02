package Bird;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
use Carp qw(croak);
use List::Rubyish;

__PACKAGE__->mk_accessors(qw(name friends followers tweets));

sub new {
    my ($self, %args) = @_;
    $self->SUPER::new({
        friends => {},
        followers  => {},
        tweets => List::Rubyish->new,
        %args,
    });
}

sub follow {
    my ($self, $user) = @_;
    croak "既にフォローしている" if $self->is_following($user);
    $self->friends->{$user->name} = $user;
    $self;
}

sub is_following {
    my ($self, $user) = @_;
    !!$self->friends->{$user->name};
}

1;

