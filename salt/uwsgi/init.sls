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
        - user: root
        - group: root
        - mode: 644
        - context:
            name: {{ name }}
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