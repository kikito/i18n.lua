local unpack = unpack or table.unpack -- lua 5.2 compat

local interpolate = {}

local FORMAT_CHARS = { c=1, d=1, E=1, e=1, f=1, g=1, G=1, i=1, o=1, u=1, X=1, x=1, s=1, q=1, ['%']=1 }

local fieldPattern = "(.?)%%{%s*(.-)%s*}"
local valuePattern = "(.?)%%<%s*(.-)%s*>%.([cdEefgGiouXxsq])"
function interpolate.getInterpolationKey(string, variables)
  for previous, key in string:gmatch(fieldPattern) do
    if previous ~= "%" and variables[key] then
      return key
    end
  end

  for previous, key in string:gmatch(valuePattern) do
    if previous ~= "%" and variables[key] then
      return key
    end
  end
end

-- matches a string of type %{age}
local function interpolateValue(string, variables)
  return string:gsub(fieldPattern,
    function (previous, key)
      if previous == "%" then
        return
      else
        return previous .. tostring(variables[key])
      end
    end)
end

-- matches a string of type %<age>.d
local function interpolateField(string, variables)
  return string:gsub(valuePattern,
    function (previous, key, format)
      if previous == "%" then
        return
      else
        return previous .. string.format("%" .. format, variables[key] or "nil")
      end
    end)
end

local function escapePercentages(string)
  return string:gsub("(%%)(.?)", function(_, char)
    if FORMAT_CHARS[char] then
      return "%" .. char
    else
      return "%%" .. char
    end
  end)
end

local function unescapePercentages(string)
  return string:gsub("(%%%%)(.?)", function(_, char)
    if FORMAT_CHARS[char] then
      return "%" .. char
    else
      return "%%" .. char
    end
  end)
end

local function interpolateString(pattern, variables)
  variables = variables or {}
  local result = pattern
  result = interpolateValue(result, variables)
  result = interpolateField(result, variables)
  result = escapePercentages(result)
  result = string.format(result, unpack(variables))
  result = unescapePercentages(result)
  return result
end

setmetatable(interpolate, {__call = function(_, ...) return interpolateString(...) end})

return interpolate
