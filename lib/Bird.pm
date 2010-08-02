package Bird;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
use List::Rubyish;

__PACKAGE__->mk_accessors(qw(name));

sub new {
    my ($self, %args) = @_;
    $self->SUPER::new({
        %args,
    });
}

1;

