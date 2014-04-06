{% for name, conf in pillar.get('webapps', {}).iteritems() %}
/home/{{ name }}/{{ name }}:
    file.directory:
        - user: {{ name }}
        - group: www-data
        - mode: 775
        - makedirs: true
        - require:
            - group: {{ name }}
            - user: {{ name }}
            - file: /home/{{ name }}

{{ conf['repo'] }}:
    git.latest:
        - rev: {{ conf.get('rev', 'master') }}
        - target: /home/{{ name }}/{{ name }}
        - force: True
        - require:
            - pkg: base-packages
            - file: /home/{{ name }}/{{ name }}
            - ssh_known_hosts: {{ conf.get('repo_type', 'github') }}
        - watch_in:
            - service: uwsgi
{% endfor %}
