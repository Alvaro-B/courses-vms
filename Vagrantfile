# =======================================================================
# VARIABLES
# =======================================================================
# 
# Xerais
PROJECT_NAME="ansible"
NETWORK = "192.168.15"
HASH_IPS = {}
NUM_WORKERS = 0
CREATE_NAT = true
# 
# MÁQUINA MASTER
MAIN_BOX="pronoide/fedoragui"
MAIN_VERSION="41"
MAIN_SERVER_SUFFIX="-control"
MEMORY_MAIN="8192"
MAIN_CPU = 2
MAIN_PLAYBOOK = "playbook-master.yml"
# 
# MINIONS
WORKER_BOX="pronoide/fedora"
WORKER_VERSION="41"
WORKER_SERVER_SUFFIX="-minion"
MEMORY_MINION="4096"
MINION_PLAYBOOK = "playbook-minion.yml"
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
  config.vm.define "#{PROJECT_NAME}#{MAIN_SERVER_SUFFIX}" do |master|
   
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
  iterable = (1..(NUM_WORKERS))
  iterable.each do |i|
    puts "*********************************************************************"
    puts "Máquina ===> #{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}, ip:#{NETWORK}.10#{i}"
    puts "*********************************************************************"
    config.vm.define "#{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}" do |node|
        node.vm.box = "#{WORKER_BOX}"
        node.vm.box_version = "#{WORKER_VERSION}"
        nat(node)
        node.vm.hostname = "#{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}"
        node.vm.provider "virtualbox" do |vb|
          vb.memory = "#{MEMORY_MINION}"
          vb.name = "#{PROJECT_NAME}#{WORKER_SERVER_SUFFIX}#{i}"
        end

        # Aprovisionar
        node.vm.provision "ansible" do |ansible|
          ansible.compatibility_mode = "2.0"
          ansible.playbook = "#{ MINION_PLAYBOOK }"
          ansible.extra_vars = {
              ip_address: "#{NETWORK}.10#{i}",
              gateway: "#{NETWORK}.1",
              entradas_hosts: HASH_IPS
          }
        end
    end
  end
end