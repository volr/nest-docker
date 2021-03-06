#!/usr/bin/env bash
#
# entrypoint.sh
#
# This file is part of NEST.
#
# Copyright (C) 2004 The NEST Initiative
#
# NEST is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# NEST is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with NEST.  If not, see <http://www.gnu.org/licenses/>.

set -e

# NEST environment
# source /home/nest/nest-install/bin/nest_vars.sh


if [ "$1" = 'notebook' ]; then
    # cd /home/nest
    exec jupyter notebook --ip="*" --port=8080 --no-browser
fi

if [ "$1" = 'interactive' ]; then
    read -p "Your python script: " name
	echo Starting: $name

	# Start
	exec /usr/bin/python3 /home/nest/data/$name
fi

exec "$@"
