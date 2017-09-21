# Primitively manage installed packages
fs = require 'fs'
cp = require 'child_process'

enc = 'utf8'

cdir = atom.getConfigDirPath()
fpathNew = "#{cdir}/packages.list"
fpathOld = "#{fpathNew}.local"

packageList = (err, data) ->
  if err
    return []
  line.split("@")[0] for line in data.trim().split "\n"

updatePackages = (oldList, newList) ->
  for pack in oldList
    if pack not in newList
      atom.packages.disablePackage pack
      cp.spawnSync "apm", ["uninstall", pack]
  for pack in newList
    if pack not in oldList
      cp.spawnSync "apm", ["install", pack]
      atom.packages.enablePackage pack

fs.readFile fpathOld, enc, (oldErr, oldData) ->
  fs.readFile fpathNew, enc, (newErr, newData) ->
    oldList = packageList oldErr, oldData
    newList = packageList newErr, newData
    updatePackages oldList, newList
    fstreamOld = fs.createWriteStream fpathOld, {encoding: enc}
    fstreamNew = fs.createWriteStream fpathNew, {encoding: enc}
    list = cp.spawn "apm", ["list", "--installed", "--bare"]
    list.stdout.pipe fstreamOld
    list.stdout.pipe fstreamNew
