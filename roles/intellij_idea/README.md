Intellij Idea
=========

Intellij Idea installer for Linux.

Requirements
------------

Internet connection to download.

Role Variables
--------------

idea_version: Actual version to compose url. Defaults to 2019.1.3

idea_owner: User to create desktop access and binary perms. Defaults to vagrant

Dependencies
------------

java role

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: intellij_idea }

License
-------

BSD

Author Information
------------------

rgomez
