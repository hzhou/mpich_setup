set -e

if test $0 != "mpich_setup/setup.sh" ; then
	echo Place "mpich_setup" in home directory and run "bash mpich_setup/setup.sh"
	exit 1;
fi

mkdir -p bin
cp mpich_setup/_bashrc .bashrc
cp mpich_setup/_vimrc  .vimrc
cp mpich_setup/get_mpich_pr.pl bin/

git clone https://github.com/pmodels/mpich mpich-github
git clone https://github.com/hzhou/mymake_mpich mymake
git clone https://github.com/hzhou/mpich-modules modules
git clone https://github.com/hzhou/MyDef MyDef

cd modules
bash build_hwloc.sh
bash build_json-c.sh
bash build_yaksa.sh
bash build_izem.sh
MODULES="hwloc json-c yaksa izem" bash build_tarball.sh
mv modules.tar.gz ..
cd ..


