-- local awful = require("awful")
-- local wibox = require("wibox")
local beautiful = require("beautiful")
local vicious = require("vicious")
-- local naughty = require("naughty")

-- BAIS - scripts module
local scripts = require("scripts")

-- BAIS - need this to make icons work
-- beautiful.init("/home/bais/.config/awesome/themes/dust/theme.lua")
-- beautiful.init("/usr/share/awesome/themes/dust/theme.lua")
beautiful.init("/home/bais/git/awesome34-themes/dust/theme.lua")

-- -- Spacers
colwidget = widget({ type = "textbox" })
colwidget.text = " | "

-- {{{ BATTERY
-- Hardcoded Paths (beautiful doesn't work)
widget_batfull = "/home/bais/git/awesome34-themes/icons/dust/batfull.png"
widget_batmed = "/home/bais/git/awesome34-themes/icons/dust/batmed.png"
widget_batempty = "/home/bais/git/awesome34-themes/icons/dust/batempty.png"
widget_ac = "/home/bais/git/awesome34-themes/icons/dust/ac.png"
widget_acblink = "/home/bais/git/awesome34-themes/icons/dust/acblink.png"

-- Battery attributes
local bat_state  = ""
local bat_charge = 0
local bat_time   = 0
local blink      = true

-- Icon
baticon = widget({ type ="imagebox" })
baticon.image = image(widget_batfull)

-- Charge %
batwidget = widget({ type ="textbox" })
vicious.register( batwidget,
                  vicious.widgets.bat,
                  function(widget, args)
                    bat_state  = args[1]
                    bat_charge = args[2]
                    bat_time   = args[3]

                    if bat_state == "-" then
                      if bat_charge > 70 then
                        baticon.image = image(widget_batfull)
                      elseif bat_charge > 30 then
                        baticon.image = image(widget_batmed)
                      elseif bat_charge > 10 then
                        baticon.image = image(widget_batlow)
                      else
                        baticon.image = image(widget_batempty)
                      end
                    else
                      baticon.image = image(widget_ac)
                      if bat_state == "+" then
                        blink = not blink
                        if blink then
                          baticon.image = image(widget_acblink)
                        end
                      end
                    end

                    return string.format("<b>%3d%% (%s%s)</b>",
                                          bat_charge,
                                          bat_state,
                                          bat_time)
                  end,
                  nil,
                  "BAT0")

-- -- Buttons
function popup_bat()
  local state = ""
  if bat_state == "↯" then
    state = "Full"
  elseif bat_state == "↯" then
    state = "Charged"
  elseif bat_state == "+" then
    state = "Charging"
  elseif bat_state == "-" then
    state = "Discharging"
  elseif bat_state == "⌁" then
    state = "Not charging"
  else
    state = "Unknown"
  end

  bat_id = naughty.notify({
    text = "Charge : " .. bat_charge .. "%\nState  : " .. state ..
          " (" .. bat_time .. ")",
    timeout = 3,
    hover_timeout = 0.5,
    replaces_id = bat_id,
  }).id
end
batwidget:buttons(awful.util.table.join(awful.button({ }, 1, popup_bat)))
baticon:buttons(batwidget:buttons())
-- End Battery}}}
--
-- {{{ Volume
-- Hardcoded Paths (beautiful doesn't work)
widget_vol = "/home/bais/git/awesome34-themes/icons/dust/vol.png"
-- Cache
vicious.cache(vicious.widgets.volume)

-- Icon
volicon = widget({ type ="imagebox" })
volicon.image = image(widget_vol)

-- Volume %
volwidget = widget({ type="textbox" })
vicious.register( volwidget,
                  vicious.widgets.volume,
                  --"$1%",
                  function(widget, args)
                    local vol = args[1]
                    local status = args[2]
                    local label = { ["♩"] = "M", ["♫"] = "♫" }
                    return string.format("%3d%s", vol, label[status])
                  end,
                  1,
                  "Master")

function volwidget:toggle()
  scripts:run("volume_toggle")
end

function volwidget:adjust(d)
  -- scripts:run("vol", d)
end

function volwidget:update()
  volwidget.volume = scripts:run("volume_volume")
  volwidget.status = scripts:run("volume_status")
end

function volwidget:notify()
  volwidget:update()
  vol_id = naughty.notify({
    title = "Volume",
    text = "Level: " .. volwidget.volume .. "%\nStatus: " .. volwidget.status,
    timeout = 3,
    hover_timeout = 0.5,
    replaces_id = vol_id,
  }).id
end
--
-- Buttons
volwidget:buttons(awful.util.table.join(
  awful.button({ }, 1,
    function()
      --awful.util.spawn_with_shell("amixer -q set Master toggle")
      volwidget:toggle()
      volwidget:notify()
    end),
  awful.button({ }, 4,
    function()
      --awful.util.spawn_with_shell("amixer -q set Master 1+% unmute")
      volwidget:adjust(1)
      volwidget:notify()
    end),
  awful.button({ }, 5,
    function()
      --awful.util.spawn_with_shell("amixer -q set Master 1-% unmute")
      volwidget:adjust(-1)
      volwidget:notify()
    end)
    )
  )
volicon:buttons(volwidget:buttons())
-- End Volume }}}
--
-- {{{ Start CPU
-- cpuicon = wibox.widget.imagebox()
-- cpuicon:set_image(beautiful.widget_cpu)
-- --
-- cpuwidget = wibox.widget.textbox()
-- --vicious.register(cpuwidget, vicious.widgets.cpu, "All: $1% 1: $2% 2: $3% 3: $4% 4: $5%", 2)
-- vicious.register( cpuwidget,
--                   vicious.widgets.cpu,
--                   --[[
--                   function(widget, args)
--                     --local mean = args[1]
--                     --local max = math.max(args[2], args[3], args[4], args[5])
--                     --local min = math.min(args[2], args[3], args[4], args[5])
--                     --return "CPU: mean " .. mean .. "% max " .. max .. "% min " .. min .. "%"
--                     --return min .. "% " .. mean .. "% " .. max .. "%"
--                     --return mean .. "% | " .. args[2] .. "% " .. args[3] .. "% " .. args[4] .. "% " .. args[5] .. "%"
--                     return args[2] .. "% " .. args[3] .. "% " .. args[4] .. "% " .. args[5] .. "%"
--                   end,
--                   --]]
--                   --"$2% $3% $4% $5%",
--                   function(widget, args)
--                     return string.format("<b>%3d%%%3d%%%3d%%%3d%%</b>",
--                                           args[2], args[3], args[4], args[5])
--                   end,
--                   2)
-- -- End CPU }}}
-- --
-- -- {{{ Start Mem
-- memicon = wibox.widget.imagebox()
-- memicon:set_image(beautiful.widget_ram)
-- --
-- memwidget = wibox.widget.textbox()
-- --vicious.register(memwidget, vicious.widgets.mem, "Mem: $1% Use: $2MB Total: $3MB Free: $4MB Swap: $5%", 2)
-- vicious.register( memwidget,
--                   vicious.widgets.mem,
--                   function(widget, args)
--                     local used = args[2]
--                     local total = args[3]
--                     local perc = math.floor(100*used/total + .5)
--                     return string.format("<b>%3d%% (%dMB)</b>", perc, used)
--                   end,
--                   2)
-- -- End Mem }}}
-- --
-- -- {{{ Start Wifi
-- wifiicon = wibox.widget.imagebox()
-- wifiicon:set_image(beautiful.widget_wifi)
-- --
-- wifi = wibox.widget.textbox()
-- --vicious.register(wifi, vicious.widgets.wifi, "${ssid} Rate: ${rate}MB/s Link: ${link}%", 3, "wlp3s0")
-- vicious.register( wifi,
--                   vicious.widgets.wifi,
--                   function(widget, args)
--                     return string.format("<b>%s rate: %dMB/s Link: %d</b>", args["{ssid}"], args["{rate}"], args["{link}"])
--                   end,
--                   17,
--                   "wlan0")
-- -- End Wifi }}}
-- --
-- -- {{{ Start Cal
-- calwidget = wibox({ type = "textbox" })
-- vicious.register( calwidget,
--                   vicious.widgets.date,
--                   "%b %d, %R",
--                   60)

-- -- Buttons
-- function popup_cal()
--   naughty.notify{ text = "BLABLA",
--                   timeout = 5,
--                   hover_timeout = 0.5
--                 }
-- end
-- calwidget:buttons(awful.util.table.join(awful.button({ }, 1, popup_cal)))
-- -- End Cal}}}
