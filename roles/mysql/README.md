mysql
=========

Rol de instalación de mysql y el workbench para consulta visual

Requirements
------------

Ninguno

Role Variables
--------------

mysql_version: Versión de mysql a descargar. (default 5.7)
mysql_workbench_version: Versión del workbench a instalar (default 6.3.8-1)

Dependencies
------------

Ninguno

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: mysql, mysql_version: 5.5 }

License
-------

BSD

Author Information
------------------

Para Pronoide
