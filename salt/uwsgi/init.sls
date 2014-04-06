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

{% for name, conf in pillar.get('webapps', {}).iteritems() %}
{% if conf.get('app') %}
/etc/uwsgi/apps-available/{{ name }}.ini:
    file.managed:
        - source: salt://uwsgi/files/app.jinja
        - template: jinja
        - user: www-data
        - group: www-data
        - mode: 755
        - context: {{ conf.get('app', {}) }}
        - defaults:
            app: application
            base: /home/{{ name }}/{{ name }}
            chdir: /home/{{ name }}/{{ name }}
            harakiri: 30
            home: /home/{{ name }}/{{ name }}/.venv
            max_requests: 5000
            module: {{ name }}.wsgi
            processes: 4
            socket: /var/run/uwsgi/app/{{ name }}/socket
        - require:
            - pkg: uwsgi_packages

/etc/uwsgi/apps-enabled/{{ name }}.ini:
    file.symlink:
        - target: /etc/uwsgi/apps-available/{{ name }}.ini
        - force: False
        - require:
            - pkg: uwsgi_packages
{% endif %}
{% endfor %}