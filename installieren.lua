-- pastebin run -f fa9gu1GJ
-- von Nex4rius
-- https://github.com/Nex4rius/Stargate-Programm

fs = require("filesystem")
wget = loadfile("/bin/wget.lua")
serverAddresse = "https://raw.githubusercontent.com/Nex4rius/Stargate-Programm/"

if fs.exists("/stargate/Sicherungsdatei.lua") then
  IDC, autoclosetime, RF, Sprache, side, installieren, control, firstrun = loadfile("/stargate/Sicherungsdatei.lua")()
else
  Sprache = ""
  control = "On"
  firstrun = -2
  installieren = false
end

if fs.exists("/stargate/sicherNachNeustart.lua") then
  if fs.exists("/stargate/adressen.lua") then
    dofile("/stargate/adressen.lua")
  end
  f = io.open("/stargate/adressen.lua", "w")
  f:write('-- pastebin run -f fa9gu1GJ\n')
  f:write('-- von Nex4rius\n')
  f:write('-- https://github.com/Nex4rius/Stargate-Programm\n--\n')
  f:write('-- to save press "Ctrl + S"\n')
  f:write('-- to close press "Ctrl + W"\n--\n')
  f:write('-- Put your own stargate addresses here\n')
  f:write('-- "" for no Iris Code\n')
  f:write('--\n\n')
  f:write('return {\n')
  f:write('--{"<Name>","<Adresse>","<IDC>"},\n')
  for k, v in pairs(adressen) do
    f:write("  " .. require("serialization").serialize(adressen[k]) .. ",\n")
  end
  if adressen[1] == nil then
    f:write('{"Name 1", "Adresse 1", "IDC 1"},\n')
    f:write('{"Name 2", "Adresse 2", "IDC 2"},\n')
  end
  f:write('}')
  f:close()
  dofile("/stargate/sicherNachNeustart.lua")
  os.execute("del /stargate/sicherNachNeustart.lua")
end

function Pfad(versionTyp)
  return serverAddresse .. versionTyp
end

function installieren()
  fs.makeDirectory("/stargate/sprache")
  if versionTyp == nil then
    versionTyp = "master"
  end
  wget("-f", Pfad(versionTyp) .. "/autorun.lua", "autorun.lua")
  wget("-f", Pfad(versionTyp) .. "/stargate/check.lua", "/stargate/check.lua")
  wget("-f", Pfad(versionTyp) .. "/stargate/version.txt", "/stargate/version.txt")
  wget("-f", Pfad(versionTyp) .. "/stargate/Kontrollprogramm.lua", "/stargate/Kontrollprogramm.lua")
  wget("-f", Pfad(versionTyp) .. "/stargate/sprache/deutsch.lua", "/stargate/sprache/deutsch.lua")
  wget("-f", Pfad(versionTyp) .. "/stargate/sprache/english.lua", "/stargate/sprache/english.lua")
  wget("-f", Pfad(versionTyp) .. "/stargate/sprache/ersetzen.lua", "/stargate/sprache/ersetzen.lua")
  if not fs.exists("/stargate/adressen.lua") then
    wget(Pfad(versionTyp) .. "/stargate/adressen.lua", "/stargate/adressen.lua")
  end
  if not fs.exists("/stargate/Sicherungsdatei.lua") then
    wget(Pfad(versionTyp) .. "/stargate/Sicherungsdatei.lua", "/stargate/Sicherungsdatei.lua")
  end
  if versionTyp == "beta" then
    f = io.open ("/stargate/version.txt", "r")
    version = f:read()
    f:close()
    f = io.open ("/stargate/version.txt", "w")
    f:write(version .. " BETA")
    f:close()
  end
  os.execute("del -v installieren.lua")
  installieren = true
  schreibSicherungsdatei()
  os.execute("reboot")
end

function schreibSicherungsdatei()
  f = io.open ("/stargate/Sicherungsdatei.lua", "w")
  f:write('-- pastebin run -f fa9gu1GJ\n')
  f:write('-- von Nex4rius\n')
  f:write('-- https://github.com/Nex4rius/Stargate-Programm\n--\n')
  f:write('-- to save press "Ctrl + S"\n')
  f:write('-- to close press "Ctrl + W"\n--\n\n')
  f:write('local IDC = "' .. tostring(IDC) .. '" -- Iris Deactivation Code\n')
  f:write('local autoclosetime = ' .. tostring(autoclosetime) .. ' -- in seconds -- false for no autoclose\n')
  f:write('local RF = ' .. tostring(RF) .. ' -- show energy in RF instead of EU\n')
  f:write('local Sprache = "' .. tostring(Sprache) .. '" -- deutsch / english\n')
  f:write('local side = "' .. tostring(side) .. '" -- bottom, top, back, front, right or left\n\n')
  f:write(string.rep("-", 70) .. '\n\n')
  f:write('local installieren = ' .. tostring(installieren) .. '\n')
  f:write('local control = "' .. tostring(control) .. '"\n')
  f:write('local firstrun = ' .. tostring(firstrun) .. '\n\n')
  f:write(string.rep("-", 70) .. '\n\n')
  f:write('if type(IDC) ~= "string" then\n  IDC = ""\nend\n')
  f:write('if type(autoclosetime) ~= "number" then\n  autoclosetime = false\nend\n')
  f:write('if type(RF) ~= "boolean" then\n  RF = false\nend\n')
  f:write('if type(Sprache) ~= "string" then\n  Sprache = ""\nend\n')
  f:write('if type(side) ~= "string" then\n  side = "unten"\nend\n')
  f:write('if type(installieren) ~= "boolean" then\n  installieren = false\nend\n')
  f:write('if type(control) ~= "string" then\n  control = "On"\nend\n')
  f:write('if type(firstrun) ~= "number" then\n  firstrun = -2\nend\n')
  f:write('if type(IDC) ~= "string" then\n  IDC = ""\nend\n\n')
  f:write('return IDC, autoclosetime, RF, Sprache, side, installieren, control, firstrun\n')
  f:close()
end

installieren()
