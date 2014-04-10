ufw:
    pkg:
        - installed

    service:
        - running
        - require:
            - pkg: ufw

ufw enable:
    cmd:
        - run
        - unless: ufw status | grep -q active
        - runas: root
        - require:
            - pkg: ufw

ufw allow OpenSS:
    cmd:
        - run
        - unless: ufw app list | grep -q OpenSSH
        - runas: root
        - require:
            - service: ufw
            - pkg: ssh

ufw allow "Nginx HTTP":
    cmd:
        - run
        - unless: ufw app list | grep -q "Nginx HTTP" 
        - runas: root
        - require:
            - service: ufw
            - pkg: nginx

ufw allow "Nginx HTTPS":
    cmd:
        - run
        - unless: ufw app list | grep -q "Nginx HTTPS" 
        - runas: root
        - require:
            - service: ufw
            - pkg: nginx
