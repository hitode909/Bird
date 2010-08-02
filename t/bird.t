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

sub attributes : Test(5) {
    my ($self) = @_;
    my $inoue = $self->{inoue};
    is $inoue->name,'井上';
    is_deeply $inoue->friends, {};
    is_deeply $inoue->followers, {};
    is_deeply $inoue->tweets, List::Rubyish->new;
    is_deeply $inoue->messages, List::Rubyish->new;
}

sub follow : Tests(6) {
    my ($self) = @_;
    my $inoue = $self->{inoue};
    my $shibata = $self->{shibata};

    ok !$inoue->is_following($shibata), '井上は柴田をfollowしてない';
    ok !$shibata->is_following($inoue), 'その逆も';

    ok $inoue->follow($shibata), '井上が柴田をfollow';

    ok $inoue->is_following($shibata), '井上は柴田をfollowしてる';
    ok $shibata->is_followed_by($inoue), '柴田は井上にをfollowされてる';
    ok !$shibata->is_following($inoue), '柴田は井上をfollowしていない';
}

sub tweet : Tests {
    my ($self) = @_;
    my $inoue = $self->{inoue};
    ok $inoue->tweet('おなかすいた'), 'tweetできる';
}

sub receive : Tests {
    my ($self) = @_;
    my $inoue = $self->{inoue};
    my $kobayashi = $self->{kobayashi};
    my $shibata = $self->{shibata};

    ok $inoue, 'ino';
    ok $kobayashi, 'koba';
    ok $shibata, 'shiba';

    ok $kobayashi->follow($inoue), '小林が井上をfollowする';

    is $kobayashi->messages->length, 0;
    is $shibata->messages->length, 0;
    ok $inoue->tweet('眠い'), '井上がなんかしゃべる';

    is $kobayashi->messages->length, 1, '小林1件受信してる';
    is $shibata->messages->length, 0, '柴田は関係ないので0件';

    ok $kobayashi->remove($inoue), '小林が井上をremoveする';

    ok $inoue->tweet('眠い(2)'), '井上がなんかしゃべる';

    is $kobayashi->messages->length, 1, '小林もう受信しない';
}

__PACKAGE__->runtests;

1;
