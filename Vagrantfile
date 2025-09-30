# =======================================================================
# VARIABLES
# =======================================================================
# 
# Xerais
PROJECT_NAME="servicios-web"
NETWORK = "192.168.15"
HASH_IPS = {}
NUM_WORKERS = 0
CREATE_NAT = false
# 
# MÁQUINA MASTER
MAIN_BOX="pronoide/fedoragui"
MAIN_VERSION="41"
MAIN_SERVER_SUFFIX=""
MEMORY_MAIN="8192"
MAIN_CPU = 2
MAIN_PLAYBOOK = "playbook-master.yml"
# 
# MINIONS
MEMORY_MINION="6144"
WORKER_SERVER_SUFFIX="-minion"
# 
# ANSIBLE MINIONS
# ---

# =======================================================================
# FUNCIÓNS
# =======================================================================
# 
# Define parámetros básicos da máquina
def add_vm_customize(vb)
    vb.customize ["modifyvm", :id, "--vram", "256"]
    vb.customize ['modifyvm', :id, '--clipboard-mode', 'bidirectional']
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    vb.customize ["modifyvm", :id, "--accelerate3d", "off"]
    vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
end


# Define IPS para /etc/hosts. Xera un hash de <maquina>:<ip>
def findIps()
    HASH_IPS["#{PROJECT_NAME}#{MAIN_SERVER_SUFFIX}"] = "#{NETWORK}.100"
    if NUM_WORKERS > 0
      iterable = (1..(NUM_WORKERS))
      iterable.each do |i|
        HASH_IPS["#{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}"] = "#{NETWORK}.#{(100 + (i))}"
      end 
    end
end

# Avalía se #{PROJECT_NAME}network existe. En caso negativo créaa.
def create_drop_nat(config)
  config.vm.provider "virtualbox" do |v|
    result = `VBoxManage natnetwork list`
    if !result.include?("#{PROJECT_NAME}network")
      v.customize ["natnetwork","add", "--netname", "#{PROJECT_NAME}network", "--network", "#{NETWORK}.0/24", "--enable"]
    end
  end
end

# Agrega unha nova interface a #{PROJECT_NAME}network
# Só necesaria en caso de ter varias máquinas que precisan verse entre elas
def nat(config)
    config.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--nic2", "natnetwork", "--nat-network2", "#{PROJECT_NAME}network", "--nictype2", "virtio"]
    end
end

# =======================================================================
# MAIN
# =======================================================================

findIps()

Vagrant.configure("2") do |config|

  # ============== MÁQUINA MASTER ===============
  config.vm.define "#{PROJECT_NAME}" do |master|
   
    # Imaxe e versión
    master.vm.box = "#{MAIN_BOX}"
    master.vm.box_version = "#{MAIN_VERSION}"
    puts "*********************************************************************"
    puts "Máquina ===> #{PROJECT_NAME}#{MAIN_SERVER_SUFFIX}, ip:#{NETWORK}.100"
    puts "*********************************************************************"

    if CREATE_NAT
      # Crea a rede
      puts "*********************************************************************"
      create_drop_nat(master)
      puts "Rede ==> #{PROJECT_NAME}network"
      puts "*********************************************************************"

      # Crea interface de rede nat para master
      nat(master)
    end

    # Configuración particular para VirtualBox.
    master.vm.hostname = "#{PROJECT_NAME}#{MAIN_SERVER_SUFFIX}"
    master.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "#{PROJECT_NAME}#{MAIN_SERVER_SUFFIX}"
      vb.memory = "#{MEMORY_MAIN}"
      vb.cpus = "#{MAIN_CPU}"
      add_vm_customize(vb)
    end

    # Aprovisionar
    puts "*********************************************************************"
    puts "Aprovisionando con #{ MAIN_PLAYBOOK }"
    puts "*********************************************************************"
    master.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "#{ MAIN_PLAYBOOK }"
      ansible.extra_vars = {
          ip_address: "#{NETWORK}.100",
          gateway: "#{NETWORK}.1",
          entradas_hosts: HASH_IPS
      }
    end
  end

  # ============== MINIONS ===============
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