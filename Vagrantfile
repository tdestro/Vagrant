# -*- mode: ruby -*-
# vi: set ft=ruby :

## make sure piece of shit symlink is not broken in vendor, otherwise vagrant up will blow up when rsyncing shit to the guest.
system("
    if [ #{ARGV[0]} = 'up' ]; then
        ls ./sites/Sylius/vendor/bitbag/cms-plugin/tests/Application/node_modules 2>/dev/null || mkdir -p ./sites/Sylius/vendor/bitbag/cms-plugin/tests/Application/node_modules
    fi
")

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define :sylius do |sylius_config|

        sylius_config.vm.box = "debian/jessie64"

        sylius_config.vm.provider "virtualbox" do |v|
            v.gui = false
            v.memory = 16048
            v.cpus = 4
            v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
            v.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 0]
            v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000]
            v.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-start", 1 ]
        end
        sylius_config.vm.synced_folder '.', "/vagrant", type: "rsync", rsync__auto: true, rsync__exclude: ['sites/Sylius/letsencrypt/']

        config.vm.provision "file", source: "~/DestroMachinesStore-2601b370cb00.json", destination: "/home/vagrant/DestroMachinesStore-2601b370cb00.json"
        config.vm.provision "file", source: "~/sources/sylius/connectcloudsql.sh", destination: "/home/vagrant/connectcloudsql.sh"

        sylius_config.vm.synced_folder "sites/", "/var/www/sites", type: "nfs", mount_options: ['rw', 'vers=3', 'tcp', 'fsc', 'nolock', 'actimeo=2']
        ## THIS IS THE IP ADDRESS THE WEBSERVER IS ACCESSIBLE FROM:
        sylius_config.vm.network "private_network", ip: "172.0.0.2"

        # Shell provisioning
        sylius_config.vm.provision :shell, :path => "shell_provisioner/run.sh"
        sylius_config.vm.provision :shell, privileged: false, path: "shell_provisioner/sylius/create.sh"
        sylius_config.vm.provision :shell, privileged: false, path: "shell_provisioner/sylius/install.sh"
    end
end
