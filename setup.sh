#!/bin/bash
# SIMUSER, SIMUID, SIMGROUP, SIMGID
groupadd $SIMGROUP -g $SIMGID 
useradd $SIMUSER -u $SIMUID -g $SIMGROUP -s /bin/bash -d /home/$SIMUSER -m
su $SIMUSER -c "echo '. /rcwa/.venv/bin/activate' >> /home/$SIMUSER/.bashrc"
su $SIMUSER -c "echo '. /rcwa/ld_library_path' >> /home/$SIMUSER/.bashrc"

# change /rcwa owner
chown $SIMUSER:$SIMGROUP /rcwa -R

# change user and run
if [[ -z "$@" || "$@" == "/bin/bash" || "$@" == "bash" ]]; then
    exec su $SIMUSER
else
    exec su $SIMUSER -c ". .venv/bin/activate && . ld_library_path && $*"
fi




