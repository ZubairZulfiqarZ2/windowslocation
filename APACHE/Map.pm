# Windows Location Plugin for OCS Inventory NG
# Copyright (C) 2025 Zubair Zulfiqar
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

package Apache::Ocsinventory::Plugins::Windowslocation::Map;

use strict;

use Apache::Ocsinventory::Map;

$DATA_MAP{windowslocation} = {
    mask => 0,
    multi => 0, # Only one location per device
    auto => 1,
    delOnReplace => 1,
    sortBy => 'LATITUDE',
    writeDiff => 0,
    cache => 0,
    fields => {
        LATITUDE => {},
        LONGITUDE => {},
        ALTITUDE => {},
				PERMISSION => {},
        HORIZONTALACCURACY => {},
        VERTICALACCURACY => {},
        SPEED => {},
        ISUNKNOWN => {},
        STATUS => {}
    }
};
1;