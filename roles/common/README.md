Common
=========

Basic configuration for Windows and Linux VMs.

For LINUX OS:

- Modify repository URL
- Stop/Start firewall
- Disable/Enable selinux
- Install basic sw. Specified in base_software variable in vars directory
- Enable/Disable ntpd service
- Enable/Disable pcsd service
- Enable/Disable screen lock
- Set terminal shortcut for paste to CTRL + V instead of CTRL + SHIFT + V
- Create a user with root privileges. Set autologin with this user when the session start. Don't ask for password when use the sudo command.
- Set default system language and keyboard language
- Set timezone
- Enable/Disable keyring
- Enable/Disable zram

For WINDOWS OS:

-

Role Variables
--------------
- username: User we want to create. 
- extra_software: List of software to install
- change_mirror: For Linux OS. [yes/no] If 'yes' you have to define de variable 'mirror'. Default: no
- mirror: For Linux OS. [head of the repo we want to use]
- common_selinux_state: For Linux OS. [disabled/enabled] Default: disabled
- disable_zram: For Linux OS. [false/true] Default: false
- disable_keyring: For Linux OS. [yes/no] Default: true

Example Playbook
----------------

- name: "Playbook inicio"
  hosts: "all"
  become: true

  tasks:
  - name: "Configuración comun"
    include_role:
      name: "common"
    vars:
      username: training
      common_selinux_state: "disabled"
      disable_keyring: true
      change_mirror: yes
      mirror: https://fr2.rpmfind.net/linux/fedora/linux 
      extra_software:
        - httpd
        - tree


