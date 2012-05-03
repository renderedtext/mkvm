# mkvm - scripts for setting up a VirtualBox VM for development

- On your host, make sure you have Ruby 1.9 and bundler gem
- Clone this repo

## Creating the VM

- Download and install [VirtualBox](www.virtualbox.org)
- Download [Ubuntu Server (11.10) 64-bit](http://releases.ubuntu.com/11.10/ubuntu-11.10-server-amd64.iso)
- In VirtualBox, create a new Linux / Ubuntu 64-bit virtual machine and name it 'mybox'
- Increase RAM (2+GB)
- Continue with "Start-up Disk", VDI, Dynamically allocated
- Increase disk size (20GB), wizard is done
- Open VM's Settings
- Attach the disk image (.iso) file to the machine's IDE controller (under Storage)
- Increase CPU cores (2+, under System/Processor)
- Start VM, go through the installation
  - use the same username as on host
  - guided - use entire disk
  - do NOT encrypt home directory
  - set hostname to 'mybox'
  - no automatic updates
  - choose to install OpenSSH server
  - let it reboot
- Power off the VM
- Set up port forwarding (from host machine, assuming it's c 2222):

```Bash
    VBoxManage modifyvm "mybox" --natpf1 "rails,tcp,,3000,,3000"
    VBoxManage modifyvm "mybox" --natpf1 "guestssh,tcp,,2222,,22"
```

- Add these lines to ~/.ssh/config on your host:

```Bash
    Host mybox
      Hostname localhost
      Port     2222
      User     USER_NAME
      ForwardX11 yes
```

## Bootstrapping

- On host you might need to `rm ~/.ssh/known_hosts`
- Start the VM
- Copy the ssh configuration from the host:

```Bash
    rsync -av ~/.ssh mybox:
```

- ssh into the VM: ssh username@mybox
- Copy the content of your local `~/.ssh/id_rsa.pub` into `~/.ssh/authorized_keys` on VM
- Set up a bash alias in `~/.bash_profile`: `alias box=ssh -Y mybox`
- Reconnect to VM with the new 'box' command
- You can now turnoff the VM and save a snapshot of this blank state

## Configuration

Chef cookbook `postgresql-bootstrap` creates a new user user and database cluster.

Place your username in `node[:postgresql_bootstrap][:username]` in
`chef/config/main.json`. This should be the username you're using your VM
with.

## Installing the stack

    bundle install --path vendor/bundle
    bundle exec cap install_stack SERVER=mybox USER=yourusername PORT=2222

## License

Copyright © 2012 [Rendered Text](http://renderedtext.com). mkvm is free software, and may be redistributed under the terms specified in the LICENSE file.
