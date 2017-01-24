
# My VMWare VM with Debian using Packer

This is my customized copy of <https://github.com/boxcutter/debian> to quickly get a fresh local Debian VM.

# How to build

I left all those configuration files `debian7*.json` and `debian8*.json` intact and created my own.

Customize variables in [my-debian8.json](my-debian8.json):

- `vm_name`
- `iso_url`, `iso_checksum`: <https://www.debian.org/distrib/netinst>, <https://www.debian.org/CD/verify>
- `headless: false`, probably
- etc

Then:

``` Shell
$ packer build -only=vmware-iso -var-file=my-debian8.json debian.json
```


# Changelog

Main template, [debian.json](debian.json):

- removed `post-processors` to skip building the vagrant box, I just need the VM
- set `vmware-iso.tools_upload_flavor = ""` and removed `vmware.sh` from `provisioners[0].scripts` to avoid installing VMWare tools, it fails to compile for me
- added [my-install-open-vmware-tools.sh](my-install-open-vmware-tools.sh) to that scripts list
- added shared folder, see `sharedFolder*.*` in `vmx_data`

At the moment of writing `vmhgfs-fuse` is in `open-vmware-tools` package >= 10.x, so I install it from backports: <https://packages.debian.org/search?keywords=open-vm-tools>.  
TODO: when the package is in main debian repo, update [my-install-open-vmware-tools.sh](my-install-open-vmware-tools.sh)


The [custom-script.sh](custom-script.sh) prepares the VM:

- adds my keys to `authorized_keys`
- disables password authentication



# How to update this copy from original repo

<https://github.com/boxcutter/debian/releases.atom>  
<https://github.com/boxcutter/debian/commits.atom>

``` Shell
$ git remote add upstream https://github.com/boxcutter/debian
$ git pull upstream master
```


