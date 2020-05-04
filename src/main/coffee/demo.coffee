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

Demo =
    animationFrame: 0
    timestamp: 0

exports.run = ->
    # begin running the game
    requestAnimationFrame nextFrame

doFrame = (timestamp) ->
    # update our metrics tracking object
    Demo.animationFrame++
    Demo.timestamp = timestamp

nextFrame = (timestamp) ->
    # safely run the frame and request the next one
    try
        doFrame timestamp
    catch error
        console.log "Error rendering frame: #{error}"
    requestAnimationFrame nextFrame

# API: make some things available to the browser
isBrowser = new Function "try{return this===window;}catch(e){return false;}"
if isBrowser()
    window.API.Demo = Demo
    window.API.ROT = ROT

#----------------------------------------------------------------------
# end of demo.coffee
