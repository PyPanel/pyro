salt-call state.highstate:
    cron:
        - present
        - minute: 0
        - hour: 0
