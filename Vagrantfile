# installation de debian via vagrant
# installation Nano, Ansible, Docker
# creation d'un container docker qui comprend nginx et le mappage des ports http & ssh

Vagrant.configure("2") do |config|
    config.vm.define "debian" do |deb|
      deb.vm.box = "debian/buster64"
      deb.vm.hostname = "debian"
      deb.vm.box_url = "debian/buster64"
        # installation de nano wget curl ansible
        deb.vm.provision "shell", inline: <<-SHELL
            # enpecher l'accés au stdin
            export DEBIAN_FRONTEND=noninteractive 
            # mise a jour & eviter erreur apt-utils
            # stdout à null pour empêcher les logs
            apt-get update -qq >/dev/null 
            apt-get install -y nano wget curl ansible
        SHELL
      # installation de la dernière version de Docker Community
      deb.vm.provision "docker" do |doc|
        # construction de l'image docker
        doc.build_image "/vagrant/", 
          args: "-t oc"
        # demarrage du container
        doc.run "oc",
          args: "-p 8080:80/tcp -p 9090:22/tcp" 
      end
      # mappage des ports 8080 => http / 9090 => ssh
      deb.vm.network "forwarded_port", guest: 8080, host: 8080
      deb.vm.network "forwarded_port", guest: 9090, host: 9090
    end
end
  