-- original code made by Bzed and published on http://awesome.naquadah.org/wiki/Calendar_widget
-- modified by Marc Dequènes (Duck) <Duck@DuckCorp.org> (2009-12-29), under the same licence,
-- and with the following changes:
--   + transformed to module
--   + the current day formating is customizable
-- modified by Jörg Thalheim (Mic92) <jthalheim@gmail.com> (2011), under the same licence,
-- and with the following changes:
--   + use tooltip instead of naughty.notify
--   + rename it to cal
--   + lua52 compliant module
--
-- 1. require it in your rc.lua
--  require("cal")
-- 2. attach the calendar to a widget of your choice (ex mytextclock)
--  cal.register(mytextclock)
--    If you don't like the default current day formating you can change it as following
--  cal.register(mytextclock, "<b>%s</b>") -- now the current day is bold instead of underlined
--
-- # How to Use #
-- Just hover with your mouse over the widget, you register and the calendar popup.
-- On clicking or by using the mouse wheel the displayed month changes.
-- Pressing Shift + Mouse click change the year.

-- local string = {format = string.format}
local os = {date = os.date, time = os.time}
local awful = require("awful")
local beautiful = require("beautiful")

local cal = {}

local tooltip
local state = {}
local current_day_format = "<u>%s</u>"

function monthCol(text, month, year)
  return 1
end

function dateIdx(text, date)
  idx = {}
  idx[1] = 4
  idx[2] = 6
  idx[3] = 8
  return idx
end

function displayMonth(state)
  local handle, text, found, curr_month, year
  
  handle = io.popen('ncal -b3hM ' .. state.month .. ' ' .. state.year)
  text = handle:read('*a')
  handle:close()
  -- BAIS - Improve cal format (that year thing)
  found, _, year = string.find(text, "^%s*(%d+)%s*\n")
  if found then
    text = string.gsub(text, "^%s*%d+%s*\n", "")
    local _, _, first_line = string.find(text, "(.-\n)")
    first_line = string.gsub(first_line, "  (%a+)   ", function(s) return s .. " " .. year end)
    text = string.gsub(text, "^.-\n", first_line)
  end
  -- BAIS - Color code the current date
  -- month_year = string.format("%s %s", state.curr_month_name, state.curr_year)
  -- found, _ = string.find(text, month_year)
  -- if found then
  --   datefmt = "<span background=\"%s\" color=\"%s\">%s</span>"
  --   datefmt = string.format(datefmt, beautiful.bg_widget, beautiful.fg_widget, state.curr_date)
  --   text = string.gsub(text, state.curr_date, datefmt)
  -- end

  -- BAIS - TODO make function to return which of the three columns is the current month (nil otherwise)
  col = monthCol(text, month, year)
  if col then
    -- BAIS - TODO make function to find characher number of first, second and third occurrence of date
    datefmt = "<span background=\"%s\" color=\"%s\">%s</span>"
    datefmt = string.format(datefmt, beautiful.bg_widget, beautiful.fg_widget, state.curr_date)

    idx = dateIdx(text, state.curr_date)
    text = string.sub(text, 0, idx[col]-1) .. datefmt .. string.sub(text, idx[col]+2)
  end
  -- BAIS - Remove final empty lines
  text = string.gsub(text, "\n*%s$", "")
  
  return text
end

function cal.register(mywidget, custom_current_day_format)
  if custom_current_day_format then current_day_format = custom_current_day_format end

  if not tooltip then
    tooltip = awful.tooltip({})
    function tooltip:update()
      -- BAIS - TODO use standard fields
      -- local text = string.format('<span color="%s" font_desc="monospace">%s</span>',
      local text = string.format('<span weight="bold" color="%s" font_desc="monospace">%s</span>',
                                  beautiful.bg_widget, displayMonth(state))
      tooltip:set_text(text)
    end
    function tooltip:reset()
      state = {}
      state.curr_date, state.curr_month, state.curr_year = os.date('%d'), os.date('%m'), os.date('%Y')
      state.curr_month_name = os.date('%B')
      state.month, state.year = state.curr_month, state.curr_year
      tooltip:update()
    end
    tooltip:reset()
  end
  tooltip:add_to_object(mywidget)

  mywidget:add_signal("mouse::enter", tooltip.reset)

  -- TODO decide once and for all: tooltips or notifications?! (notifications are cooler, but tooltips are faster)
  mywidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function()
    switchMonth(-1)
  end),
  awful.button({ }, 2, function()
    tooltip:reset()
  end),
  awful.button({ }, 3, function()
    switchMonth(1)
  end),
  awful.button({ }, 4, function()
    switchMonth(-1)
  end),
  awful.button({ }, 5, function()
    switchMonth(1)
  end),
  awful.button({ 'Shift' }, 1, function()
    switchMonth(-12)
  end),
  awful.button({ 'Shift' }, 3, function()
    switchMonth(12)
  end),
  awful.button({ 'Shift' }, 4, function()
    switchMonth(-12)
  end),
  awful.button({ 'Shift' }, 5, function()
    switchMonth(12)
  end)))
end

function switchMonth(delta)
  state.month = state.month - 1 + delta
  state.year = state.year + math.floor(state.month/12)
  state.month = state.month % 12 + 1

  tooltip:update()
end

return cal
