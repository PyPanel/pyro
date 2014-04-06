#
# webapps:
    exampleapp:
        repo: git@github.com:someuser/somerepo.git
        site:
            type: uwsgi
        app:
            venv: True
            requirements: requirements.pip
        database:
            password: somepass
#

webapps:
    testflaskapp:
        repo: git@github.com:PyPanel/testflaskapp.git 
        site:
            type: uwsgi
