#!/usr/bin/bash

mkdir -p exports

set -e

echo -e "\033[1;92m
######################################################################################################################################
####### Copy tarballs
######################################################################################################################################\033[0m"
sudo mkdir -p /runner/project
sudo cp -r collections_tarballs /runner/project


echo -e "\033[1;92m
######################################################################################################################################
####### APPLY: Null
######################################################################################################################################\033[0m"
ansible-playbook configure_aap.yml -e aap_version=25 -e object_set=null -e delete_objects=true --vault-password-file ansible_vault\
                 > exports/export_25_Null.txt 2>&1


echo -e "\033[1;92m
######################################################################################################################################
####### VERIFY: Null
######################################################################################################################################\033[0m"
/bin/cat exports/export_25_Null.txt | grep changed


echo -e "\033[1;92m
######################################################################################################################################
####### APPLY: Empty
######################################################################################################################################\033[0m"
ansible-playbook configure_aap.yml -e aap_version=25 -e object_set=empty -e delete_objects=true --vault-password-file ansible_vault


echo -e "\033[1;92m
######################################################################################################################################
####### GET: Empty
######################################################################################################################################\033[0m"
ansible-playbook get_objects.yml


echo -e "\033[1;92m
######################################################################################################################################
####### CHECK: Set A
######################################################################################################################################\033[0m"
ansible-playbook configure_aap.yml -e aap_version=25 -e object_set=A --vault-password-file ansible_vault --check


echo -e "\033[1;92m
######################################################################################################################################
####### APPLY: Set A
######################################################################################################################################\033[0m"
ansible-playbook configure_aap.yml -e aap_version=25 -e object_set=A -e delete_objects=true -e wait_project_sync=true\
                                   -e trigger_inventory_sync=true --vault-password-file ansible_vault


echo -e "\033[1;92m
######################################################################################################################################
####### GET: Set A
######################################################################################################################################\033[0m"
ansible-playbook get_objects.yml > exports/export_25_A.txt 2>&1


echo -e "\033[1;92m
######################################################################################################################################
####### APPLY: Set B | ORG limit
######################################################################################################################################\033[0m"
ansible-playbook configure_aap.yml -e aap_version=25 -e object_set=B --tags controller_config -e "{'limit_organizations':['Org D','Org E']}"\
                                   -e delete_objects=true -e wait_project_sync=true --vault-password-file ansible_vault\
                 > exports/export_25_ORG_LIMIT.txt 2>&1


echo -e "\033[1;92m
######################################################################################################################################
####### VERIFY: Set B | Org limit
######################################################################################################################################\033[0m"
/bin/cat exports/export_25_ORG_LIMIT.txt | grep changed | grep -Ev 'D1|D2|E1|E2'


echo -e "\033[1;92m
######################################################################################################################################
####### CHECK: Set B
######################################################################################################################################\033[0m"
ansible-playbook configure_aap.yml -e aap_version=25 -e object_set=B --vault-password-file ansible_vault --check


echo -e "\033[1;92m
######################################################################################################################################
####### APPLY: Set B
######################################################################################################################################\033[0m"
ansible-playbook configure_aap.yml -e aap_version=25 -e object_set=B -e delete_objects=true\
                                   -e wait_project_sync=true --vault-password-file ansible_vault


echo -e "\033[1;92m
######################################################################################################################################
####### GET: Set B
######################################################################################################################################\033[0m"
ansible-playbook get_objects.yml > exports/export_25_B.txt 2>&1


echo -e "\033[1;92m
######################################################################################################################################
####### CHECK: Set B (idempotency)
######################################################################################################################################\033[0m"
ansible-playbook configure_aap.yml -e aap_version=25 -e object_set=B --vault-password-file ansible_vault --check\
                 > exports/export_25_B_idempotency_check.txt 2>&1


echo -e "\033[1;92m
######################################################################################################################################
####### APPLY: Set B (idempotency)
######################################################################################################################################\033[0m"
ansible-playbook configure_aap.yml -e aap_version=25 -e object_set=B --vault-password-file ansible_vault\
                 >> exports/export_25_B_idempotency_check.txt 2>&1


echo -e "\033[1;92m
######################################################################################################################################
####### VERIFY: Set B (idempotency)
######################################################################################################################################\033[0m"
/bin/cat exports/export_25_B_idempotency_check.txt | grep changed


echo -e "\033[1;92m
######################################################################################################################################
####### DONE
######################################################################################################################################\033[0m"
