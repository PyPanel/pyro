{% for name, conf in pillar.get('webapps', {}).iteritems() %}
/home/{{ name }}/.ssh:
    file.directory:
        - user: {{ name }}
        - group: {{ name }}
        - mode: 700
        - makedirs: True
        - require:
            - file.directory: /home/{{ name }}

ssh_auth_{{ name }}:
    ssh_auth.present:
        - user: {{ name }}
        - source: salt://ssh/files/{{ name }}.id_rsa.pub
        - require:
            - file.directory: /home/{{ name }}/.ssh

/home/{{ name }}/.ssh/known_hosts:
    file.managed:
        - user: {{ name }}
        - group: {{ name }}
        - mode: 700
        - require:
            - file.directory: /home/{{ name }}/.ssh

bitbucket_{{ name }}:
    ssh_known_hosts.present:
        - name: bitbucket.org
        - user: {{ name }}
        - fingerprint: 97:8c:1b:f2:6f:14:6b:5c:3b:ec:aa:46:46:74:7c:40
        - require:
            - file: /home/{{ name }}/.ssh/known_hosts

github_{{ name }}:
    ssh_known_hosts.present:
        - name: github.com
        - user: {{ name }}
        - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48
        - require:
            - file: /home/{{ name }}/.ssh/known_hosts
{% endfor %}