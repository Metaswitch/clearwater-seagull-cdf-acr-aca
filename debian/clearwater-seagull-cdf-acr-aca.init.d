#!/bin/bash
# @file clearwater-seagull-cdf-acr-aca.init.d
#
# Project Clearwater - IMS in the Cloud
# Copyright (C) 2014 Metaswitch Networks Ltd
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation, either version 3 of the License, or (at your
# option) any later version, along with the "Special Exception" for use of
# the program along with SSL, set forth below. This program is distributed
# in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU General Public License for more
# details. You should have received a copy of the GNU General Public
# License along with this program. If not, see
# <http://www.gnu.org/licenses/>.
#
# The author can be reached by email at clearwater@metaswitch.com or by
# post at Metaswitch Networks Ltd, 100 Church St, Enfield EN2 6BQ, UK
#
# Special Exception
# Metaswitch Networks Ltd grants you permission to copy, modify,
# propagate, and distribute a work formed by combining OpenSSL with The
# Software, or a work derivative of such a combination, even if such
# copying, modification, propagation, or distribution would otherwise
# violate the terms of the GPL. You must comply with the GPL in all
# respects for all of the code used other than OpenSSL.
# "OpenSSL" means OpenSSL toolkit software distributed by the OpenSSL
# Project and licensed under the OpenSSL Licenses, or a work based on such
# software and licensed under the OpenSSL Licenses.
# "OpenSSL Licenses" means the OpenSSL License and Original SSLeay License
# under which the OpenSSL Project distributes the OpenSSL toolkit software,
# as those licenses appear in the file LICENSE-OPENSSL.

### BEGIN INIT INFO
# Provides: clearwater-seagull-cdf-acr-aca
# Required-Start: $network $local_fs
# Required-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: clearwater-seagull-cdf-acr-aca
# Description: clearwater-seagull-cdf-acr-aca
### END INIT INFO

do_auto_config()
{
  . /etc/clearwater/config
  ipv4prefix='0x0001'
  hex_address=$(printf '%02X' ${local_ip//./ })
  sed -e "s/SEAGULL_LOCAL_IP_AS_HEX/$ipv4prefix$hex_address/g" \
      -e "s/HOME_DOMAIN/$home_domain/g" -i /usr/share/clearwater/exe-env/diameter-env/scenario/acr-aca.server.xml
  sed -e 's/SEAGULL_LOCAL_IP/'$local_ip'/g' -i /usr/share/clearwater/exe-env/diameter-env/config/ralf.server.xml
  /usr/share/clearwater/exe-env/diameter-env/run/start_server_ralf.ksh
}

case "$1" in
  start|restart|reload|force-reload)
    do_auto_config
    exit 0
  ;;

  status|stop)
    exit 0
  ;;

  *)
    echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
    exit 3
  ;;
esac

:
