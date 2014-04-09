#
# webapps:
#    exampleapp:
#        repo:
#           url: git@github.com:someuser/somerepo.git
#           rev: master
#        site:
#            type: uwsgi
#        app:
#            venv: True
#            requirements: requirements.pip
#        database:
#            password: somepass
#

webapps:
    testflaskapp:
        repo:
            url: git@github.com:PyPanel/testflaskapp.git 
        site:
            domain: testflaskapp
        app:
            type: uwsgi
        app:
            venv: True
