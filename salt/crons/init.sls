include:
    - crons

salt-call state.highstate:
    cron:
        - present
        - minute: '*/15'
