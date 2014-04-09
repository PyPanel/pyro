nginx:
    pkg.installed

    service.running:
        - enable: True
        - require:
            - pkg: nginx
        - watch:
            - file: /etc/nginx/nginx.conf
            - file: /etc/nginx/conf.d/*.conf
            - file: /etc/nginx/mime.types
            - file: /etc/nginx/sites-enabled/*

/etc/nginx/sites-enabled/default:
    file.absent

{% for name, conf in pillar.get('webapps', {}).iteritems() %}
{% if conf.get('site') %}
/etc/nginx/sites-available/{{ name }}.conf:
    file.managed:
        - source: salt://nginx/files/site.jinja
        - template: jinja
        - user: root
        - group: root
        - mode: 644
        - require:
            - pkg: nginx
        - context: {{ conf.get('site', {}) }}
        - defaults:
            root: /home/{{ name }}/www
            site_type: static
            ssl: False

/etc/nginx/sites-enabled/{{ name }}.conf:
    file.symlink:
        - target: /etc/nginx/sites-available/{{ name }}.conf
        - watch_in:
            - service: nginx
        - require:
            - pkg: nginx
{% endif %}
{% endfor %}
