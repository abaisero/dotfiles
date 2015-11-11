require("naughty")

scripts = {}
scripts.bin = os.getenv("HOME") .. "/bin/"

function scripts:run(name, args)
  -- TODO test with arguments.. more than one too
  local cmd = string.format("%s%s %s", scripts.bin, name, (args or ""))
  return os.execute(cmd)
end

function scripts:run_or_notify(name, args)
  if scripts:run(name, args) ~= 0 then
    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Scripts.run_or_notify()",
      text = string.format("Something went wrong with script '%s' and arguments %s.", name, args),
    })
  end
end

return scripts
