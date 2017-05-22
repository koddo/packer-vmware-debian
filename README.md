
# My VMWare VM with Debian using Packer

This is my customized copy of <https://github.com/boxcutter/debian> to quickly get a fresh local Debian VM.

# How to build

I left all those configuration files `debian7*.json` and `debian8*.json` intact and created my own.

Customize variables in [my-debian8-vars.json](my-debian8-vars.json):

- `vm_name`
- `iso_url`, `iso_checksum`
- `headless: false`, probably
- etc

Debian images are here: <https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/>; fingerprints for keys are here: <https://www.debian.org/CD/verify>.

``` Shell
$ gpg --keyserver keyring.debian.org --recv-keys 6294BE9B     # this is "Debian CD signing key <debian-cd@lists.debian.org>"
$ gpg --verify SHA256SUMS.sign SHA256SUMS    # fingerprint must be: DF9B 9C49 EAA9 2984 3258  9D76 DA87 E80D 6294 BE9B, check <https://www.debian.org/CD/verify>
```

Then:

``` Shell
$ packer build -only=vmware-iso -var-file=my-debian8-vars.json my-debian8.json
```

# Shared dirs

Here they are: `/mnt/hgfs/`

# After build check these

- login
- shared dirs

# Changelog

Main template, [my-debian8.json](my-debian8.json):

- removed `post-processors` to skip building the vagrant box, I just need the VM
- set `vmware-iso.tools_upload_flavor = ""` and removed `vmware.sh` from `provisioners[0].scripts` to avoid installing VMWare tools, it fails to compile for me
- added [my-install-open-vmware-tools.sh](my-install-open-vmware-tools.sh) to that scripts list
- added a shared folder, see `sharedFolder*.*` in `vmx_data`
- added a hostname var

At the moment of writing `vmhgfs-fuse` is in `open-vmware-tools` package >= 10.x, so I install it from backports: <https://packages.debian.org/search?keywords=open-vm-tools>.  
TODO: when the package is in main debian repo, update [my-install-open-vmware-tools.sh](my-install-open-vmware-tools.sh)


The [custom-script.sh](custom-script.sh) prepares the VM:

- adds my keys to `authorized_keys` and disables password authentication
- enables shared directories in `/mnt/vmshared/`
- enables accessing the vm by bonjour/zeroconf using `libnss-mdns`
- etc

# How to update this copy from original repo

<https://github.com/boxcutter/debian/releases.atom>  
<https://github.com/boxcutter/debian/commits.atom>

``` Shell
$ git remote add upstream https://github.com/boxcutter/debian
$ git pull upstream master
```


# Misc

TODO: put ansible roles here for docker, compose, etc  
also `$ apt-get install -y silversearcher-ag`

