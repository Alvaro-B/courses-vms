Jupyter Notebook
=========

This Ansible role automates the installation and configuration of Jupyter Notebook with optional support for PySpark and R.
It installs Jupyter for a specified user, configures PySpark to use Jupyter as its driver, and optionally sets up the Spylon (Scala) and IRkernel (R) extensions.

Features:

- Installs Jupyter Notebook via pip
- Configures PySpark to run in Jupyter (optional)
- Adds Scala (Spylon) and R kernel support (optional)

Requirements
------------

none

Role Variables
--------------

jupyter_notebook_owner: (default: vagrant)
jupyter_notebook_r: (default: false)
jupyter_notebook_pyspark: (default: true)
jupyter_notebook_pyspark_auto: (default: false)

Dependencies
------------

none

Example Playbook
----------------

- name: Rol jupyter notebook
  include_role:
    name: jupyter_notebook
  vars:
    jupyter_notebook_owner: "{{ base_username }}"
    jupyter_notebook_r: false
    jupyter_notebook_pyspark: true
    jupyter_notebook_pyspark_auto: false

Tested
----------------

- CentOS 9 Stream (jupyter_notebook_pyspark)
