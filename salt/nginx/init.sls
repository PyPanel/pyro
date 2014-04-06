nginx-packages:
    pkg.installed:
        - names:
            - nginx

nginx:
    service.running:
        - enable: True
        - require:
            - pkg: nginx-packages
        - watch:
            - file: /etc/nginx/nginx.conf
            - file: /etc/nginx/conf.d/*.conf
            - file: /etc/nginx/mime.types
            - file: /etc/nginx/sites-enabled/*

/etc/nginx/sites-enabled/default:
    file.absent

{% for name, conf in pillar.get('webapps', {}).iteritems() %}
/etc/nginx/sites-available/{{ name }}.conf:
    file.managed:
        - source: salt://nginx/files/site.jinja
        - template: jinja
        - user: www-data
        - group: www-data
        - mode: 755
        - require:
            - pkg: nginx-packages
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
            - pkg: nginx-packages
{% endfor %}