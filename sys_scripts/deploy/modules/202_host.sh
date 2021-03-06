#!/bin/bash
# Installs the host package and symlinks host to hostx

back="$(pwd)"

# Install our package if needed.
emerge -u host || exit 1

ourFolder="$(dirname $(which hostx))"
if [ -z "${ourFolder}" ]; then
    echo "Cannot find folder for host." >&2
    exit 1
fi

# Setup the symlink if needed
echo -n "Creating our symlink..."
cd "${ourFolder}" || exit 1
if [ ! -e host ]; then
    ln -s hostx host || exit 1
    echo 'done.'
else
    echo 'skipped.'
fi
cd ${back} || exit 1

# Make sure symlink works
echo -n "Validating symlink..."
[ "$(which host)" ] || exit 1
echo 'done.'

# All done.
exit 0
