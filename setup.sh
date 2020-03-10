set -e

if test $0 != "mpich_setup/setup.sh" ; then
	echo Place "mpich_setup" in home directory and run "bash mpich_setup/setup.sh"
	exit 1;
fi

cp mpich_setup/_bashrc .bashrc
cp mpich_setup/_vimrc  .vimrc

git clone https://github.com/pmodels/mpich mpich-github
git clone https://github.com/hzhou/mymake_mpich mymake
git clone https://github.com/hzhou/mpich-modules modules
git clone https://github.com/hzhou/MyDef MyDef

cd modules
bash build_hwloc.sh
bash build_jsonc.sh
MODULES="hwloc json-c" bash build_tarball.sh
mv modules.tar.gz ..
cd ..


