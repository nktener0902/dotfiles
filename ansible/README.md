# Install ansible

If you are using MacOS, type following commands.

```bash
# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Ansible
brew install ansible
```

If you are using another OS, refer to [Ansible Installation Guide](https://docs.ansible.com/ansible/2.7/installation_guide/intro_installation.html#latest-releases-via-apt-ubuntu).

# Execute ansible playbook

Before executing this ansible playbook, you have to check what packages will be installed.
For example, homebrew packages installed in MacOS are listed up in `./roles/homebrew/vars/main.yml`.

After checking them, type following commands to configure your machine.

```bash
# If you are using MacOS, set HOMEBREW_CASK_OPTS environment variable.
echo "export HOMEBREW_CASK_OPTS='--appdir=/Applications'" >> ~/.bash_profile
source ~/.bash_profile
ansible-playbook -i hosts site.yml
```

If password is required to become super user, type following command instead of the last one of above commands.

```bash
ansible-playbook -i hosts site.yml --ask-become-pass
```
