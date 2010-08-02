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

sub attributes : Test(4) {
    my ($self) = @_;
    my $inoue = $self->{inoue};
    is $inoue->name,'井上';
    is_deeply $inoue->friends, {};
    is_deeply $inoue->followers, {};
    is_deeply $inoue->tweets, List::Rubyish->new;
}

sub follow : Tests(5) {
    my ($self) = @_;
    my $inoue = $self->{inoue};
    my $shibata = $self->{shibata};

    ok !$inoue->is_following($shibata), '井上は柴田をfollowしてない';
    ok !$shibata->is_following($inoue), 'その逆も';

    ok $inoue->follow($shibata), '井上が柴田をfollow';

    ok $inoue->is_following($shibata), '井上は柴田をfollowしてる';
    ok !$shibata->is_following($inoue), '柴田は井上をfollowしていない';
}

__PACKAGE__->runtests;

1;
