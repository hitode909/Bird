package Bird;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
use Carp qw(croak);
use List::Rubyish;

use Message;

__PACKAGE__->mk_accessors(qw(name friends followers tweets messages));

sub new {
    my ($self, %args) = @_;
    $self->SUPER::new({
        friends => {},
        followers  => {},
        tweets => List::Rubyish->new,
        messages => List::Rubyish->new,
        %args,
    });
}

sub friends_list {
    my ($self) = @_;
    List::Rubyish->new(values %{$self->friends});
}

sub followers_list {
    my ($self) = @_;
    List::Rubyish->new(values %{$self->followers});
}

sub follow {
    my ($self, $user) = @_;
    croak "既にフォローしている" if $self->is_following($user);
    $self->friends->{$user->name} = $user;
    $user->followers->{$self->name} = $self;
    $self;
}

sub remove {
    my ($self, $user) = @_;
    croak "フォローしてない" unless $self->is_following($user);
    delete $self->friends->{$user->name};
    delete $user->followers->{$self->name};
    $self;
}

sub is_following {
    my ($self, $user) = @_;
    !!$self->friends->{$user->name};
}

sub is_followed_by {
    my ($self, $user) = @_;
    !!$self->followers->{$user->name};
}

sub tweet {
   my ($self, $body) = @_;
   my $message = Message->new({
       author => $self,
       body => $body,
       });
   $message->deliver;
   $self;
}

sub receive_message {
    my ($self, $message) = @_;
    $self->messages->push($message);
    $self;
}



1;

