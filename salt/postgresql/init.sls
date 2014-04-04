postgresql-packages:
    pkg:
        - installed
        - names:
            - postgresql-9.1
            - python-psycopg2
            - postgresql-server-dev-9.1

postgresql:
    service:
        - running
        - enable: True
        - watch:
            - file: /etc/postgresql/9.1/main/pg_hba.conf
        - require:
            - pkg: postgresql-packages

/etc/postgresql/9.1/main/pg_hba.conf:
    file:
        - managed
        - source: salt://postgresql/files/pg_hba.conf
        - user: postgres
        - group: postgres
        - mode: 644
        - require:
            - pkg: postgresql-packages