{% for name, conf in pillar.get('webapps', {}).iteritems() %}
{{ name }}:
    group.present
    user.present:
        - home: /home/{{ name }}
        - groups:
            - {{ name }}
        - require:
            - group: {{ name }}

/home/{{ name }}:
    file.directory:
        - user: {{ name }}
        - group: {{ name }}
        - mode: 750
        - makedirs: True
        - require:
            - user: {{ name }}
{% endfor %}
