git:
    pkg.installed

{% for name, conf in pillar.get('webapps', {}).iteritems() %}
/home/{{ name }}/www:
    file.directory:
        - user: {{ name }}
        - group: www-data
        - mode: 775
        - makedirs: true
        - require:
            - file.directory: /home/{{ name }}

{% if conf.get('repo') %}
{{ conf['repo']['url'] }}:
    git.latest:
        - rev: {{ conf['repo'].get('rev', 'master') }}
        - target: /home/{{ name }}/www
        - force: True
        - require:
            - pkg: git
            - file.directory: /home/{{ name }}/www
            - ssh_known_hosts: {{ conf['repo'].get('type', 'github') }}
        - watch_in:
            - service: uwsgi
{% endif %}
{% endfor %}
