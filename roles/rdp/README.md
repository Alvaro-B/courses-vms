RDP
=========

Rol de servicio RDP.

Requirements
------------

De momento solo es funcional en CentOS 7

Role Variables
--------------

La variable existente es:
rdp_owner: vagrant

Dependencies
------------

No posee dependencias

Example Playbook
----------------

Ejemplo de uso:

```yaml
---
- name: Playbook proyecto-template
  hosts: all
  become: true
  vars:
    base_username: template
  tasks:
    # Instalación de RDP 
    # Permite abrir el puerto 3389 de la maquina virtual para conexión remota por RDP
    # Para que funcione hay que abrir el puerto en Virtualbox:
    #  - Se puede ir a network->nat->advanced->forwarded-ports y agregarlo a mano
    #    name: rdp host_port: 3389 guest_port: 3389 - No hace falta rellenar más secciones. Ya funciona con eso.
    #  - Se puede agregar en el Vagrantfile la directiva: 
    #    config.vm.network "forwarded_port", guest: 3389, host: 3389
    # Es necesario reiniciar la instancia o iniciar sesión una vez para conectarse en remoto.
    - name: Instalar RDP
      include_role:
        name: rdp
      vars:
        rdp_owner: "{{ base_username }}"
```

License
-------

Por determinar.

Author Information
------------------

Rubén Gómez García
