# Cakefile
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

BROWSER_COMMAND = "firefox --new-tab"

#-------------------------------------------------------------------------------

{exec} = require "child_process"
project = require "./package.json"

execAsync = (command) ->
    return new Promise (resolve, reject) ->
        exec command, (err, stdout, stderr) ->
            return reject err if err?
            resolve {stdout: stdout, stderr: stderr}

#-------------------------------------------------------------------------------

task "check", "Check dependency versions", ->
    for dependency of project.dependencies
        await checkVersion dependency, project.dependencies[dependency]
    for dependency of project.devDependencies
        await checkVersion dependency, project.devDependencies[dependency]

task "clean", "Remove build cruft", ->
    clean()

task "coverage", "Perform test coverage analysis", ->
    clean -> compile -> test -> coverage()

task "dist", "Create distribution tarball", ->
    clean -> compile -> test -> browser -> tar()

task "rebuild", "Rebuild the module", ->
    clean -> compile -> test -> browser()

task "run", "Run the module", ->
    clean -> compile -> test -> browser -> run()

#-------------------------------------------------------------------------------

browser = (next) ->
    exec "node_modules/.bin/browserify main.js > #{project.name}.js", (err, stdout, stderr) ->
        throw err if err
        next?()

clean = (next) ->
    exec "rm -fR #{project.name}.js #{project.name}*.tar.xz lib/* test/*", (err, stdout, stderr) ->
        throw err if err
        next?()

compile = (next) ->
    exec "node_modules/.bin/coffee -o lib/ -c src/main/coffee", (err, stdout, stderr) ->
        throw err if err
        exec "node_modules/.bin/coffee -o test/ -c src/test/coffee", (err, stdout, stderr) ->
            throw err if err
            next?()

coverage = (next) ->
    exec "node_modules/.bin/nyc --reporter=html node_modules/.bin/_mocha --recursive", (err, stdout, stderr) ->
        throw err if err
        exec "#{BROWSER_COMMAND} coverage/index.html", (err, stdout, stderr) ->
            throw err if err
            next?()

run = (next) ->
    exec "#{BROWSER_COMMAND} --new-tab index.html", (err, stdout, stderr) ->
        throw err if err
        next?()

tar = (next) ->
    exec "tar cvJf #{project.name}-#{project.version}.tar.xz index.html #{project.name}.css #{project.name}.js", (err, stdout, stderr) ->
        throw err if err
        next?()

test = (next) ->
    exec "node_modules/.bin/mocha --colors --recursive", (err, stdout, stderr) ->
        console.log stdout + stderr
        throw err if err
        next?() if stderr.indexOf("AssertionError") < 0

#-------------------------------------------------------------------------------

checkVersion = (dependency, version) ->
    {stdout} = await execAsync "npm info --json #{dependency}"
    {latest} = JSON.parse(stdout)["dist-tags"]
    if latest isnt version
        console.log "[OLD] #{dependency} is out of date #{version} vs. #{latest}"

#----------------------------------------------------------------------
# end of Cakefile
