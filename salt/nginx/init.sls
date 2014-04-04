nginx-packages:
    pkg:
        - installed
        - names:
            - nginx

nginx:
    service:
        - running
        - enable: True
        - require:
            - pkg: nginx-packages
        - watch:
            - file: /etc/nginx/nginx.conf
            - file: /etc/nginx/conf.d/*.conf
            - file: /etc/nginx/mime.types
            - file: /etc/nginx/sites-enabled/*

/etc/nginx/sites-enabled/default:
    file:
        - absent