### Local Gentoo overlay

The local overlay consists of a few packages not included in offical Gentoo repository.

#### Usage

Create a file under `/etc/portage/repos.conf/` and add the following:

```
[local]
location = /path/to/ebuilds
sync-type = git
sync-uri = https://github.com/hungshihhan/local-overlay.git
priority=9999
```
where `location` is the path to where the ebuilds are being stored, e.g., you can put it under `/usr/local/overlay/local`. Then perfom `emerge --sync` and you are ready to emerge.
