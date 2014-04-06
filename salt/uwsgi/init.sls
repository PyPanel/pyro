uwsgi_packages:
    pkg.installed:
        - names:
            - uwsgi
            - uwsgi-extra
            - uwsgi-plugin-python

uwsgi:
    service.running
        - enable: True
        - require:
            - pkg: uwsgi_packages
        - watch:
            - file: /etc/uwsgi/apps-enabled/*