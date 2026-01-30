sudo apt install neovim -y
sudo apt install python3-neovim -y
mkdir -p $HOME/.config/nvim
cp .vimrc $HOME/.vimrc
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.local/bin
pushd ~/.local/bin
curl -LO https://github.com/equalsraf/win32yank/releases/latest/download/win32yank.exe
chmod +x win32yank.exe
echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.bash_profile
popd

echo 'alias vim="nvim"' >> $HOME/.bash_profile
echo ""
echo 'Please run "source $HOME/.bash_profile".'
echo 'After launching Neovim for the first time, run :PlugInstall to install the plugins.'

