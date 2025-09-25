# Declaración de variables
PROJECT_NAME="git"
MEMORY="6144"
# MAIN_SERVER_SUFFIX="-master"
# WORKER_SERVER_SUFFIX="-slave"
# FQDN_BASE=".local"
# NETWORK = "192.168.15"
# NUM_WORKERS = 0
# HASH_IPS = {}
def add_vm_customize(vb)
    #VM_GUI_CUSTOMIZE_START
    vb.customize ["modifyvm", :id, "--vram", "256"]
    vb.customize ['modifyvm', :id, '--clipboard-mode', 'bidirectional']
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    vb.customize ["modifyvm", :id, "--accelerate3d", "off"]
    vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
    #VM_GUI_CUSTOMIZE_END
end
# Generación de IPS para /etc/hosts. Genera un hash de <nombre_maquina>:<ip>
# def findIps()
#     HASH_IPS["#{PROJECT_NAME}#{MAIN_SERVER_SUFFIX}#{FQDN_BASE}"] = "#{NETWORK}.100"
#     if NUM_WORKERS > 0
#       iterable = (1..(NUM_WORKERS))
#       iterable.each do |i|
#         HASH_IPS["#{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}#{FQDN_BASE}"] = "#{NETWORK}.#{(100 + (i))}"
#       end 
#     end
# end
# Función que evalua si la red nat llamada kubenetwork no existe la crea.
# def create_drop_nat(config)
#   config.vm.provider "virtualbox" do |v|
#     result = `VBoxManage natnetwork list`
#     if !result.include?("#{PROJECT_NAME}network")
#       v.customize ["natnetwork","add", "--netname", "#{PROJECT_NAME}network", "--network", "#{NETWORK}.0/24", "--enable"]
#     end
#   end
# end
# Función que agrega una nueva interfaz a la red kubenetwork
# def nat(config)
#     config.vm.provider "virtualbox" do |v|
#       v.customize ["modifyvm", :id, "--nic2", "natnetwork", "--nat-network2", "#{PROJECT_NAME}network", "--nictype2", "virtio"]
#     end
# end

# findIps()

Vagrant.configure("2") do |config|
  config.vm.define "#{PROJECT_NAME}" do |master|
    # Nombre de imagen y versión
    master.vm.box = "pronoide/fedoragui"
    master.vm.box_version = "41"
    # puts "Maquina: #{PROJECT_NAME}#{MAIN_SERVER_SUFFIX}#{FQDN_BASE}, ip:#{NETWORK}.100"
    # Configuración de nombre de maquina para respuesta dns (edita el etc/hosts)
    # Evalua y genera la red
    # create_drop_nat(master)
    # Genera la interfaz de red nat para master
    # nat(master)
    master.hostmanager.manage_host = false
    master.hostmanager.ignore_private_ip = false
    master.hostmanager.include_offline = true
    # Configuración deshabilitada de proxy
    master.proxy.enabled = false
    master.proxy.http     = "http://usuario:pass@proxy:puerto"
    master.proxy.https    = "http://usuario:pass@proxy:puerto"
    # Habría que agregar también cualquier red interna o nombre de máquina que utilicemos para que no use el proxy
    master.proxy.no_proxy = "localhost,127.0.0.1"
    # Configuración particular para VirtualBox. En mac --accelerate3d esta en off por un bug
    master.vm.hostname = "#{PROJECT_NAME}"
    master.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "#{PROJECT_NAME}"
      vb.memory = "#{MEMORY}"
      vb.cpus = 2
      add_vm_customize(vb)
    end
    # Fichero de provisionamiento de software
    master.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "playbook-master.yml"
      # ansible.extra_vars = {
      #     ip_address: "#{NETWORK}.100",
      #     gateway: "#{NETWORK}.1",
      #     entradas_hosts: HASH_IPS
      # }
    end
  end
  # iterable = (1..(NUM_WORKERS))
  # iterable.each do |i|
  #   config.vm.define "#{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}#{FQDN_BASE}" do |node|
  #       node.vm.box = "pronoide/fedora"
  #       node.vm.box_version = "37"
  #       puts "Maquina: #{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}#{FQDN_BASE}, ip:#{NETWORK}.10#{i}"
  #       nat(node)
  #       node.vm.hostname = "#{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}#{FQDN_BASE}"
  #       node.vm.provider "virtualbox" do |vb|
  #         vb.memory = "3072"
  #         vb.name = "#{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}#{FQDN_BASE}"
  #       end
  #       node.vm.provision "ansible" do |ansible|
  #         ansible.compatibility_mode = "2.0"
  #         ansible.playbook = "playbook-slave.yml"
  #         ansible.extra_vars = {
  #         ip_address: "#{NETWORK}.10#{i}",
  #         gateway: "#{NETWORK}.1",
  #         entradas_hosts: HASH_IPS
  #     }
  #       end
  #   end
  # end
end