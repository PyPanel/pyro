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
        - onlyif: ufw status \ grep -q inactive
        - require:
            - pkg: ufw

ufw logging on:
    cmd:
        - run
        - unless: ufw status \ grep -q inactive
        - require:
            - pkg: ufw

ufw default deny:
    cmd:
        - run
        - unless: ufw status \ grep -q inactive
        - require:
            - pkg: ufw

ufw allow OpenSSH:
    cmd:
        - run
        - unless: ufw app list \ grep -q OpenSSH
        - require:
            - service: ufw
            - pkg: ssh

ufw allow "Nginx Full":
    cmd:
        - run
        - unless: ufw app list \ grep -q "Nginx HTTP" 
        - require:
            - service: ufw
            - pkg: nginx

ufw allow "Nginx HTTP":
    cmd:
        - run
        - unless: ufw app list \ grep -q "Nginx HTTP" 
        - require:
            - service: ufw
            - pkg: nginx

ufw allow "Nginx HTTPS":
    cmd:
        - run
        - unless: ufw app list \ grep -q "Nginx HTTPS" 
        - require:
            - service: ufw
            - pkg: nginx
