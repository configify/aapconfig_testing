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

```
sudo mkdir -p /runner/project &&
sudo cp -r collections_tarballs /runner/project &&

echo "######################################################################################\n####### NONE\n######################################################################################" &&

ansible-playbook configure_aap_2.4_Null.yml -e delete_objects=true &&

echo "######################################################################################\n####### EMPTY APPLY\n######################################################################################" &&

ansible-playbook configure_aap_2.4_Empty.yml -e delete_objects=true &&

echo "######################################################################################\n####### GET ALL (EMPTY)\n######################################################################################" &&

ansible-playbook get_objects.yml &&

echo "######################################################################################\n####### SET A CHECK\n######################################################################################" &&

ansible-playbook configure_aap_2.4_SetA.yml --check &&

echo "######################################################################################\n####### SET A APPLY\n######################################################################################" &&

ansible-playbook configure_aap_2.4_SetA.yml -e delete_objects=true -e wait_project_sync=true -e trigger_inventory_sync=true &&

echo "######################################################################################\n####### GET ALL (SET A)\n######################################################################################" &&

ansible-playbook get_objects.yml &&

echo "######################################################################################\n####### SET B CHECK\n######################################################################################" &&

ansible-playbook configure_aap_2.4_SetB.yml --check &&

echo "######################################################################################\n####### SET B APPLY\n######################################################################################" &&

ansible-playbook configure_aap_2.4_SetB.yml -e delete_objects=true -e wait_project_sync=true &&

echo "######################################################################################\n####### GET ALL (SET B)\n######################################################################################" &&

ansible-playbook get_objects.yml
```

Review logs.
Confirm that exported objects match configurations.

Playbooks below should not report anything "changed":

```
ansible-playbook configure_aap_2.4_SetB.yml --check &&
ansible-playbook configure_aap_2.4_SetB.yml
```

Build collection and import into HUB

### Testing against AAP 2.5

```
sudo mkdir -p /runner/project &&
sudo cp -r collections_tarballs /runner/project &&

echo "######################################################################################\n####### NONE\n######################################################################################" &&

ansible-playbook configure_aap_2.5_Null.yml -e delete_objects=true &&

echo "######################################################################################\n####### EMPTY APPLY\n######################################################################################" &&

ansible-playbook configure_aap_2.5_Empty.yml -e delete_objects=true &&

echo "######################################################################################\n####### GET ALL (EMPTY)\n######################################################################################" &&

ansible-playbook get_objects.yml &&

echo "######################################################################################\n####### SET A CHECK\n######################################################################################" &&

ansible-playbook configure_aap_2.5_SetA.yml --check &&

echo "######################################################################################\n####### SET A APPLY\n######################################################################################" &&

ansible-playbook configure_aap_2.5_SetA.yml -e delete_objects=true -e wait_project_sync=true -e trigger_inventory_sync=true &&

echo "######################################################################################\n####### GET ALL (SET A)\n######################################################################################" &&

ansible-playbook get_objects.yml &&

echo "######################################################################################\n####### SET B CHECK\n######################################################################################" &&

ansible-playbook configure_aap_2.5_SetB.yml --check &&

echo "######################################################################################\n####### SET B APPLY\n######################################################################################" &&

ansible-playbook configure_aap_2.5_SetB.yml -e delete_objects=true -e wait_project_sync=true &&

echo "######################################################################################\n####### GET ALL (SET B)\n######################################################################################" &&

ansible-playbook get_objects.yml
```

Review logs.
Confirm that exported objects match configurations.

Playbooks below should not report anything "changed":

```
ansible-playbook configure_aap_2.5_SetB.yml --check &&
ansible-playbook configure_aap_2.5_SetB.yml
```

Build collection and import into HUB
