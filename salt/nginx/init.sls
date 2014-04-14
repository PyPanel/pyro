nginx:
    pkg:
        - installed

    service:
        - running
        - enable: True
        - require:
            - pkg: nginx
        - watch:
            - file: /etc/nginx/sites-enabled/*

/etc/nginx/sites-enabled/default:
    file:
        - absent

{% for name, conf in pillar.get('webapps', {}).iteritems() %}
{{ name }}_www_data:
    user:
        - present
        - name: www-data
        - groups:
            - {{ name }}
        - require:
            - pkg: nginx
            - group: {{ name }}

{% if conf.get('site') %}
/etc/nginx/sites-available/{{ name }}.conf:
    file:
        - managed
        - source: salt://nginx/files/site.jinja
        - template: jinja
        - user: root
        - group: root
        - mode: 644
        - require:
            - pkg: nginx
        - context:
            name: {{ name }}
            domain: {{ conf['site']['domain'] }}
            {% if conf['site'].get('aliases') %}
            aliases:
            {%- for alias in conf['site']['aliases'] %}
            - {{ alias }}
            {%- endfor %}
            {% else %}
            aliases: False
            {% endif %}
            ssl: {{ conf['site'].get('ssl', False) }}
            app_type: {{ conf['app'].get('type', 'static') }}
            default: False
            static_prefix: False

/etc/nginx/sites-enabled/{{ name }}.conf:
    file:
        - symlink
        - target: /etc/nginx/sites-available/{{ name }}.conf
        - watch_in:
            - service: nginx
        - require:
            - pkg: nginx
{% endif %}
{% endfor %}
