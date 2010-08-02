package Message;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
use Carp qw(croak);
use DateTime;

__PACKAGE__->mk_accessors(qw(author body created_on));

sub new {
    my ($class, $args) = @_;
    $class->SUPER::new({
#        created_on => DateTime->now,
        %$args,
    });
}

sub deliver {
    my ($self) = @_;
    $self->author->followers_list->each(sub {
        $_->receive_message($self);
    });
    $self;
}

1;

