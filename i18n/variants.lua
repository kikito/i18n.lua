local variants = {}

local function reverse(arr, length)
  local result = {}
  for i=1, length do result[i] = arr[length-i+1] end
  return result, length
end

local function concat(arr1, len1, arr2, len2)
  for i = 1, len2 do
    arr1[len1 + i] = arr2[i]
  end
  return arr1, len1 + len2
end

function variants.ancestry(locale)
  local result, length, accum = {},0,nil
  locale:gsub("[^%-]+", function(c)
    length = length + 1
    accum = accum and (accum .. '-' .. c) or c
    result[length] = accum
  end)
  return reverse(result, length)
end

function variants.isParent(parent, child)
  return not not child:match("^".. parent .. "%-")
end

function variants.root(locale)
  return locale:match("[^%-]+")
end

function variants.fallbacks(locales)
  local in_seen = {}
  local out_seen = {}
  local ancestry, length = {}, 0
  for index, value in ipairs(locales) do
      if not in_seen[value] then
          in_seen[value] = true
          local ancestry1, length1 = variants.ancestry(value)
          for i = 1, length1 do
              if not out_seen[ancestry1[i]] then
                  out_seen[ancestry1[i]] = true
                  ancestry[#ancestry + 1] = ancestry1[i]
              end
          end
      end
  end

  return ancestry, length
end

return variants
