Rol Java
=========

Rol que permite instalar java en el servidor.

Requirements
------------

De momento solo sirve para instalar java jdk en servidores CentOS 7

Role Variables
--------------

java_major_version: 8 - Podemos decidir la versión que queremos
java_minor_version: 191 - Subversión elegida
java_build: '13' -  Build de la versión
java_hash: 96a7b8442fe848ef90c96a2fad6ed6d1 - Hash generado por Oracle usado para componer la url de descarga
java_platform: linux - Plataforma
java_arch: x64 - bits
java_package: rpm - paquete de descarga, de momento solo admite rpm.

Dependencies
------------

No posee dependencias excepto la de CentOS 7

Example Playbook
----------------

Ejemplo de uso:

    - hosts: servers
      roles:
         - { role: java }

License
-------

MIT

Author Information
------------------

rgomez@pronoide.es
