#!/bin/bash
log_path='/var/log/pacman.log'

upgrades_to_read=1
verbose=0

while [[ $# -gt 0 ]]; do
    case $1 in
        -n)
            upgrades_to_read=$2 ;;
        -v)
            verbose=1 ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1 ;;
    esac
    shift
done

tac $log_path | awk -v upgrades_to_read=$upgrades_to_read -v verbose=$verbose '
BEGIN {
    upgraded = 0;
    upgrade = 0;
    split("", upgrade_msgs);
}
{
    if (match($0, "upgraded")) {
        if (verbose == 1) {
            upgrade_msgs[upgraded] = substr($0, RSTART + RLENGTH + 1);
        }
        upgraded++;
    }
    if (match($0,"starting full system upgrade")) {
        match($0, /[0-9]+\-[0-9]+\-[0-9]+/, a);
        split(a[0], date, "-");
        printf("%s.%s.%s: %d packages upgraded.\n", date[3], date[2], date[1], upgraded);

        if (verbose == 1) {
            for (key in upgrade_msgs) {
                print upgrade_msgs[key];
            }
            print "";
        }

        split("", upgrade_msgs);
        upgraded = 0;

        upgrade++;
        if (upgrade == upgrades_to_read)
            exit;
    }
}'
