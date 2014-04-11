#
# webapps:
#    exampleapp:
#        repo:
#           type: bitbucket (default: github)
#           url: git@github.com:someuser/somerepo.git (required)
#           rev: develop (default: master)
#        site:
#            domain: yourdomain.com (required)
#            aliases: (optional)
#               - www.yourdomain.com
#        app:
#            type: uwsgi (default: static)
#            venv: True (default: False)
#            reqs: requirements.pip (optional)
#        postgresql: (optional)
#            password: somepass (required)
#

webapps:
    testflaskapp:
        repo:
            url: https://github.com/PyPanel/testflaskapp.git
        site:
            domain: testflaskapp
        app:
            type: uwsgi
            venv: True
            reqs: requirements.txt
