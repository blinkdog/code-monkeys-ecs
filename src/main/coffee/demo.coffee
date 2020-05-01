# demo.coffee
# Copyright 2020 Patrick Meade
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#----------------------------------------------------------------------

ROT = require "rot-js"

exports.MESSAGE = MESSAGE = "Hello, Code-Monkeys!"

exports.run = ->
    console.log MESSAGE
    console.log "There is a #{ROT.RNG.getPercentage()}% chance you'll like this game!"

#----------------------------------------------------------------------
# end of demo.coffee
