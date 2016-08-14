bootstrap
----

My personal collection of [ansible]() playbooks for bootstrapping my various systems.

# Local Install

`$ ./bootstrap.sh`

This will bootstrap an Ubuntu, Arch Linux, or OS X machine by installing and updating all tools required to run `ansible-playbook` locally.

If `BOOTSTRAP_USER` environment variable is set, then that user will be provisioned. Otherwise, the `bootstrap.sh` will prompt for a username or use the current ssh user's name.

# Remote Install

```
$ ansible-playbook --inventory-file environment/{cloud,home} \
                   --limit {host} \
                   --ask-sudo-pass \
                   bootstrap.yml
```

# Vagrant

Use Vagrant to test changes against virtual machines.
Runs `./bootstrap.sh` locally on the guest machine.

`$ vagrant up`

# Environments

**Local:** Meant to run _on_ a machine rather than SSH _into_ a machine.

**Home:** Machines at home

**Cloud:** Machines in the cloud
