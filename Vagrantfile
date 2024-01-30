# -*- mode: ruby -*-
# vi: set ft=ruby :

## make sure piece of shit symlink is not broken in vendor by checking for the existence of the directory it links to and creating it if needed,
## otherwise vagrant up will blow up when rsyncing shit to the guest.
system("
    if [ #{ARGV[0]} = 'up' ]; then
        ls ./sites/Sylius/vendor/sylius/paypal-plugin/tests/Application/node_modules 2>/dev/null||mkdir -p ./sites/Sylius/vendor/sylius/paypal-plugin/tests/Application/node_modules
    fi
")

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define :sylius do |sylius_config|

        sylius_config.vm.box = "debian/bookworm64"

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
        config.vm.provision "file", source: "connectcloudsql.sh", destination: "/home/vagrant/connectcloudsql.sh"
        config.vm.provision "file", source: "sylius.local.key", destination: "/home/vagrant/sylius.local.key"
        config.vm.provision "file", source: "sylius.local.crt", destination: "/home/vagrant/sylius.local.crt"

        sylius_config.vm.synced_folder "sites/", "/var/www/sites", type: "nfs", nfs_udp: false, nfs_version: 3
        ## THIS IS THE IP ADDRESS THE WEBSERVER IS ACCESSIBLE FROM:
        sylius_config.vm.network "private_network", ip: "192.168.56.100"

        # Shell provisioning
        sylius_config.vm.provision :shell, :path => "shell_provisioner/run.sh"
    end
end
