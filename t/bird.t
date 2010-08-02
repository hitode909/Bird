package test::Bird;
use strict;
use warnings;
use base qw(Test::Class);
use Test::More;
use Test::Exception;
use Bird;

sub setup_users : Test(setup) {
    my ($self) = @_;
    $self->{inoue} = Bird->new(name => '井上');
    $self->{kobayashi} = Bird->new(name => '小林');
    $self->{shibata} = Bird->new(name => '柴田');
}

sub init : Test(1) {
    new_ok 'Bird';
}

sub name : Test(1) {
    my ($self) = @_;
    is $self->{inoue}->name,'井上';
}

__PACKAGE__->runtests;

1;
