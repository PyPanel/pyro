git:
    pkg:
        - installed

{% for name, conf in pillar.get('webapps', {}).iteritems() %}
{% if conf.get('repo') %}
/home/{{ name }}/www:
    file:
        - directory
        - user: {{ name }}
        - group: www-data
        - mode: 775
        - makedirs: True
        - require:
            - file: /home/{{ name }}

{{ conf['repo']['url'] }}:
    git:
        - latest
        - rev: {{ conf['repo'].get('rev', 'master') }}
        - target: /home/{{ name }}/www
        - user: {{ name }}
        - force: True
        - require:
            - pkg: git
            - file: /home/{{ name }}/www
            - ssh_known_hosts: {{ conf['repo'].get('type', 'github') }}_{{ name }}
        - watch_in:
            - service: uwsgi
{% endif %} 
{% endfor %}
