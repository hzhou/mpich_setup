my $pr = $ARGV[0];

open In, "curl https://api.github.com/repos/pmodels/mpich/pulls/$pr | " or die;

my ($author, $branch);
while (<In>){
    if (/^\s*"label":\s*"(\w+):(\S+)",/){
        if($1 ne "pmodels"){
            ($author, $branch)=($1, $2);
            last;
        }
    }

}
close In;
die if !$author;

# system "git clone https://github.com/pmodels/mpich mpich$pr";
system "git clone $ENV{HOME}/mpich-github mpich$pr";
chdir "mpich$pr";

system "git remote add gh-$author https://github.com/$author/mpich";
system "git fetch gh-$author";
system "git checkout -b $branch gh-$author/$branch";
