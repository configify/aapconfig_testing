# Testing tasks

TLDR:

1. Linting
1. Test 2.4 -> Compare exports to set A/B
1. Test 2.5 -> Compare exports to set A/B
1. Build collection and test in Hub 2.4/2.5

## Linting

```
ansible-lint * &&
ansible-test sanity
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

THese are the rough steps that would be required:

1. Deploy desired version of AAP
1. If new dev box:

```
pip install awxkit
mkdir -p ansible_collections
export ANSIBLE_COLLECTIONS_PATH=ansible_collections
git clone https://github.com/configify/aapconfig_testing.git
mkdir ansible_collections
< install collections and export variables>
```

1. Update environment variables with:
  - admin user personal tokens (CONTROLLER_OAUTH_TOKEN, GATEWAY_API_TOKEN)
  - aap hostnames (CONTROLLER_HOST, AH_HOST, GATEWAY_HOSTNAME)

1. Update **configure_aap.yml** with:
  - hubsync hub tokens (**hub_pat** variables)


# Testing with different python/pip versions

As an example for ansible 2.16:

```
sudo dnf install python3.11 python3.11-pip
pip3.11 install ansible-core==2.16.14 ansible-lint

ansible --version
ansible-lint --version
```
