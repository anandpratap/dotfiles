#
mkdir -p ~/local
cd ~/local
if [ -d `readlink -f "dotemacs"` ]
then
	cd dotemacs
	git pull
else
	git clone git@github.com:anandpratap/dotemacs.git
	cd dotemacs
fi


make -B
cd ../

cd ~/local
if [ -d `readlink -f "dotfiles"` ]
then
	cd dotfiles
	git pull
else
	git clone git@github.com:anandpratap/dotfiles.git
	cd dotfiles
fi
make -B
cd ../
