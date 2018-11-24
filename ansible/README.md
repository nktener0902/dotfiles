# Install ansible

If you are using MacOS, input following commands.

```bash
# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Ansible
brew install ansible
```

# Execute ansible playbook

Before do this, you have to check what packages will be installed by this ansible playbook.
For example, homebrew packages installed by `./mac/exec.yml` are listed up on `./mac/roles/homebrew/vars/main.yml`.

```bash
cd mac
echo "export HOMEBREW_CASK_OPTS='--appdir=/Applications'" >> ~/.bash_profile
source ~/.bash_profile
ansible-playbook -i hosts exec.yml
```
