#
# webapps:
#     exampleapp:
#         repo:
#             type: github
#             url: git@github.com:someuser/somerepo.git
#             rev: master
#         site:
#             domain: domain.com
#             aliases:
#                 - www.domain.com
#         app:
#             type: uwsgi
#             venv: True
#             requirements: requirements.pip
#         database:
#             type: postgresql
#             password: somepass
#

webapps:
    testflaskapp:
        repo:
            url: git@github.com:PyPanel/testflaskapp.git 
        site:
            domain: testflaskapp
        app:
            type: uwsgi
