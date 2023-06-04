LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
mkdir -p tmp
cd tmp
git clone https://github.com/ronniedroid/getnf.git
cd getnf
./install.sh
