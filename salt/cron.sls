salt-call state.highstate:
    cron:
        - present
        - minute: 0
