uwsgi:
    pkg.installed:
        - names:
            - uwsgi
            - uwsgi-extra
            - uwsgi-plugin-python

    service.running
        - enable: True
        - require:
            - pkg: uwsgi
        - watch:
            - file: /etc/uwsgi/apps-enabled/*

{% for name, conf in pillar.get('webapps', {}).iteritems() %}
{% if conf.get('app') and conf['app'].get('type') == 'uwsgi' %}
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
            base: /home/{{ name }}/www
            chdir: /home/{{ name }}/www
            harakiri: 30
            home: /home/{{ name }}/venv
            max_requests: 5000
            module: {{ name }}.wsgi
            processes: 4
            socket: /var/run/uwsgi/app/{{ name }}/socket
        - require:
            - pkg: uwsgi

/etc/uwsgi/apps-enabled/{{ name }}.ini:
    file.symlink:
        - target: /etc/uwsgi/apps-available/{{ name }}.ini
        - force: False
        - require:
            - pkg: uwsgi
{% endif %}
{% endfor %}