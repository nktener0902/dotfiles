# Install ansible

If you are using MacOS, input following commands.

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install ansible
```

# Execute ansible playbook

```bash
export HOMEBREW_CASK_OPTS='--appdir=/Applications'
ansible-playbook -i hosts exec.yml
```
