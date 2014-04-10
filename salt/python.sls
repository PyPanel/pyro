python:
    pkg:
        - installed
        - names:
            - python-dev
            - python-virtualenv
            - python-pip

{% for name, conf in pillar.get('webapps', {}).iteritems() %}
{% if conf.get('app') and conf['app'].get('venv', True) %}
/home/{{ name }}/venv:
    file:
        - directory
        - user: {{ name }}
        - grou: www-data
        - mode: 775
        - makedirs: True
        - require:
            - file: /home/{{ name }}

    virtualenv:
        - managed
        - requirements: /home/{{ name }}/www/{{ conf['app'].get('requirements', 'requirements.txt') }}
        - clear: False
        - runas: {{ name }}
        - require:
            - file: /home/{{ name }}/venv
            - file: /home/{{ name }}/www/{{ conf['app'].get('requirements', 'requirements.txt') }}
            - pkg: python_packages
{% endif %}
{% endfor %}
