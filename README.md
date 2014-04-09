Pyro
====

A Heroku-like deployments using Salt.

This set of Salt sates will set up a Nginx, PostgreSQL and uWSGI stack
driven by a Git repository with minimal configuration.

Conventions
-----------

* Each ``webapp`` is treated as its own Linux user and group, each with the same
  name. The ``webapp`` name is specified in the ``webapps.sls`` pillar.

* The ``webapp`` name should match the Python module name being deployed. If
  the ``webapp`` name is ``exampleapp``, the repo should have a subdirectory
  with the same name and a ``__init__.py``. Example.
  ``exampleapp/__init__.py``.

* A submodule called ``wsgi`` should be created defining an ``application`` to
  run. For example, ``exampleapp/wsgi.py``.

* Each ``webapp`` is deployed to the user's home directory, such as
  ``/home/exampleapp/www``. The ``www`` directory represents the root of the
  Git repo being deployed.

* A PostgresSQL database and user will be created, both using the ``webapp`` namee.

* If a virtualenv is being used, it will be created under the user's home
  directory as ``/home/exampleapp/venv``. By default a ``requirements.txt``
  file in the Git repo's root directory will be used to build this virtualenv,
  but a different requirements filename can be specified.

* Logs will be stored in the user's home directory under
  ``/home/exampleapp/log``.

* Sockets will be stored in the user's home directory under
  ``/home/exampleapp/run``.
