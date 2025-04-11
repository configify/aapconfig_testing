# Testing tasks

TLDR:

1. Linting
1. Test 2.4 -> Compare exports to set A/B
1. Test 2.5 -> Compare exports to set A/B
1. Build collection and test in Hub 2.4/2.5


## Linting

Assuming we are in the repo root and that Controller, Hub (and Gateway if required) environment variables are set, run:

```
export ANSIBLE_COLLECTIONS_PATH=ansible_collections &&
rm -rf ~/.cache &&
ansible-lint * &&
cd ansible_collections/configify/aapconfig/ &&
ansible-test sanity --skip-test shebang --skip-test line-endings --python 3.9 &&
ansible-test sanity --skip-test shebang --skip-test line-endings --python 3.11 &&
cd ../../..
```


## Testing from command line

### Testing against AAP 2.4

- Run tests
```
./24_testing.sh
```

- Review logs

- Confirm that exported objects match configurations:
  - export_24_A.txt
  - export_24_B.txt

- If everything looks good test running things in AAP:
  - push new collection (and other changes) into testing repo
  - sync Project Z
  - run Template Z


### Testing against AAP 2.5

- Run tests
```
./24_testing.sh
```

- Review logs

- Confirm that exported objects match configurations:
  - export_25_A.txt
  - export_25_B.txt

- If everything looks good test running things in AAP:
  - push new collection (and other changes) into testing repo
  - sync Project Z
  - run Template Z


# Configuring new test environment

These are the rough steps that would be required:

- Deploy desired version of AAP
- If new dev box:

```
pip install ansible-core awxkit
sudo dnf install python3.11 python3.11-pip -y
pip3.11 install ansible-lint

git clone https://github.com/configify/aapconfig_testing.git

mkdir ansible_collections
export ANSIBLE_COLLECTIONS_PATH=ansible_collections

ansible-galaxy collection install infra.ah_configuration
ansible-galaxy collection install ansible.utils
ansible-galaxy collection install ansible.hub

ansible-galaxy collection install ../ansible-controller-4.6.7.tar.gz
ansible-galaxy collection install ../ansible-platform-2.5.20241218.tar.gz
```

- For testing against AAP 2.5:

```
pip3.11 install ansible-core==2.16.14
```

- Check versions

```
ansible --version
ansible-lint --version
```

- Update environment variables with:
  - AAP admin user personal tokens (CONTROLLER_OAUTH_TOKEN, GATEWAY_API_TOKEN)
  - aap hostnames (CONTROLLER_HOST, AH_HOST, GATEWAY_HOSTNAME)

- Update **configure_aap.yml** with:
  - hubsync hub tokens (**hub_pat** variables)
  - Red Hat Hub and GitHub tokens if necessary (**github_pat** and **rhhub_pat**)
