Cloudera
=========

Rol que permite instalar los distintos tipos de servidores de Cloudera

Requirements
------------

CentOS 7.0

Role Variables
--------------

server_type: Variable que permite indicar el tipo de servidor a instalar, puede ser master o slave

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: cloudera; server: master }

License
-------

Licenciado para su uso en Pronoide S.L.

Author Information
------------------

Rubén Gómez García
