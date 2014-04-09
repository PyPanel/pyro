Vagrant.configure("2") do |config|
    config.vm.box = "precise32"
    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    config.vm.synced_folder "./", "/srv"

    config.vm.provision :salt do |salt|
        salt.run_highstate = false
        salt.minion_config = "minion.conf"
    end
end
