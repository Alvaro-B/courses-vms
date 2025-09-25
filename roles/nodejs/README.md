Rol NodeJs
=========

Rol que permite instalar nodejs en el servidor.

Requirements
------------

De momento solo sirve para instalar NodeJS en servidores CentOS 7

Role Variables
--------------

nodejs_version: 10.x (Versión de NodeJS que se quiere instalar, 10.x 9.x etc.)
package_name: nodejs (Valor por defecto, nombre del binario de node para instalar)

Dependencies
------------

No posee dependencias excepto la de CentOS 7

Example Playbook
----------------

Ejemplo de uso:

    - hosts: servers
      roles:
        - role: nodejs
		  vars:
		    nodejs_version: 10.x

License
-------

MIT

Author Information
------------------

rgomez@pronoide.es
