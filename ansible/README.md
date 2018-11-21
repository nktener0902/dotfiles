# Install ansible

If you are using MacOS, input following commands.

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install ansible
```

# Execute ansible playbook

You have to check packages that will be installed by this ansible playbook.
For example, homebrew packages installed by `./mac/exec.yml` are listed up on `./mac/roles/homebrew/vars/main.yml`.

```bash
cd mac
export HOMEBREW_CASK_OPTS='--appdir=/Applications'
ansible-playbook -i hosts exec.yml
```
