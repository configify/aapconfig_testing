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
