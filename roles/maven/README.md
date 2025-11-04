Maven
=========

This Ansible role automates the installation of Apache Maven.
It downloads and extracts the Maven package, and sets the Maven binary directory in the $PATH environment variable.

Requirements
------------

none

Role Variables
--------------

maven_filename
maven_base_path
maven_mirror

Defaults
--------------

maven_version: 3.9.11
maven_java_option: openjdk
maven_openjdk_version: 21

Dependencies
------------

java

Example Playbook
----------------

- name: Instalación de maven
  include_role:
    name: maven
  vars:
    maven_version: "{{ maven_v }}"
    maven_java_option: openjdk
    maven_openjdk_version: "{{ maven_java_version }}"

Tested
----------------

- CentOS 9 Stream
