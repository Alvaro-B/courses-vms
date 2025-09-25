Scala role
=========

Instalador de scala. Descomprime y agrega al path

Requirements
------------

No tiene requerimientos previos.

Role Variables
--------------

En default:
scala_version: '2.12.8' por defecto. Se puede definir la versión de scala que necesitemos.
scala_owner: vagrant por defecto. Define el usuario dueño de la instalación

En vars:
scala_mirror_url: https://downloads.lightbend.com como url por defecto de descarta. Se puede cambiar por otro mirror.
scala_base_path: /usr/local/scala-{{ scala_version }} - Path de instalación para las variables de entorno.
scala_base_name: SCALA - Nombre para definir la variable principal. SCALA_HOME (por defecto debe ser esta)

Dependencies
------------

Dependencia con rol java. En principio versión 8 que es por defecto la que otorga el rol.

Example Playbook
----------------

Ejemplo de uso:

    - hosts: servers
      roles:
         - { role: scala, scala_version: 2.12.8, scala_owner: scala }

License
-------

MIT

Author Information
------------------

rgomez@pronoide.es
