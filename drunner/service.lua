-- drunner service configuration for minimalexample

-- add any configuration variables needed with:
-- addconfig( VARIABLENAME, DEFAULTVALUE, DESCRIPTION )

function uninstall()
  stop()
-- stop services, e.g. with dockerstop
end

function obliterate()
-- e.g. call dockerdeletevolume(volumename)
end

function install()
  dockerpull("mysql:5.6")
-- e.g. pull relevant containers with dockerpull, create volumes with dockercreatevolume
end

function backup()
-- pause containers with docker("pause",containername), backup volumes with dockerbackup(volumename), then unpause
end

function restore()
-- restore volumes with dockerrestore(volumename)
end

function selftest()
-- exercise any custom functions we'd like
end

function start()
  start_mysql()
  -- dieunless( dockerwait("${SERVICENAME}-mysql", "3306"), "MySQL did not respond.")
  result,output=docker("run", "-d", "--name", "${SERVICENAME}", "-p", "80:80", "--link", "${SERVICENAME}-mysql:mysql", "symphony")
end

function stop()
  dockerstop("${SERVICENAME}")
  dockerstop("${SERVICENAME}-mysql")
end

function start_mysql()
  result,output=docker("run", "-d", "--name", "${SERVICENAME}-mysql",
    "-e", "MYSQL_ROOT_PASSWORD=symphony",
    "-e", "MYSQL_DATABASE=symphony",
    "mysql:5.6")
end

-- past here are functions that can be run from the commandline,
-- e.g. minimalexample help


function help()
   return [[
   NAME
      ${SERVICENAME} - does nothing.

   SYNOPSIS
      ${SERVICENAME} help  - This help
   ]]
end