### Local Gentoo overlay

The local overlay consists of a few packages not included in offical Gentoo repository.

#### Usage

Create a file under `/etc/portage/repos.conf/` and add the following:

```
[local]
location = /path/to/ebuilds
sync-type = git
sync-uri = https://path/to/github/repo
priority=9999
```
where `location` is the path to where the ebuilds are being stored, e.g., you can put it under `/usr/local/overlay/local`. Then perfom `emerge --sync` and you are ready to emerge.

#### Harden your desktop

To harden your desktop, you may want to create a hybrid profile which inherits both desktop and hardened profile. For detailed instruction, please refer to Gentoo Wiki at https://wiki.gentoo.org/wiki/Profile_(Portage). Sync the repo and switch to the profile
```
# eselect profile list
...
[54]  local:hardened/plasma (dev) *

# eselect profile set 54
```
Finally run an update to see if the new set of use flags comes into effect.
