logrotate:
    pkg.installed

{% for name, conf in pillar.get('webaps', {}).iteritems() %}
/home/{{ name }}/log:
    file.directory:
        - user: {{ name }}
        - group: www-data
        - mode: 775
        - makedirs: True
        - require:
            - file.directory: /home/{{ name }}

/etc/logrotate.d/{{ name }}:
    file.managed:
        - source: salt://logrotate/files/logrotate.jinja
        - template: jinja
        - user: root
        - group: root
        - mode: 644
        - require:
            - pkg: logrotate
        - context:
            name: {{ name }}
{% endfor %}
