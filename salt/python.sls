python:
    pkg:
        - installed
        - names:
            - python-dev
            - python-virtualenv
            - python-pip

{% for name, conf in pillar.get('webapps', {}).iteritems() %}
{% if conf.get('app') and conf['app'].get('venv', False) %}
/home/{{ name }}/venv:
    file:
        - directory
        - user: {{ name }}
        - group: www-data
        - mode: 775
        - makedirs: True
        - require:
            - file: /home/{{ name }}

    virtualenv:
        - managed
        {%- if conf['app'].get('reqs') %}
        - requirements: /home/{{ name }}/www/{{ conf['app']['reqs'] }}
        {%- endif %}
        - clear: False
        - runas: {{ name }}
        - require:
            - file: /home/{{ name }}/venv
            - pkg: python
{% endif %}
{% endfor %}
