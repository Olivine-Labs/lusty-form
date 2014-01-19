local url = {}
local form = {}

function url.encode(s)
  return s and (s:gsub(
    "%W",
    function (c)
      return string.format("%%%02x", c:byte())
    end)
  )
end

function url.decode(s)
  return s and (s:gsub(
    "%%(%x%x)",
    function (c)
      return string.char(tonumber(c,16))
    end)
  )
end

local function formencodepart(s)
  return s and (s:gsub("%W", function (c)
    if c ~= " " then
      return string.format("%%%02x", c:byte());
    else
      return "+";
    end
  end));
end

function form.encode(form)
  local result = {};
  if form[1] then -- Array of ordered { name, value }
    for _, field in ipairs(form) do
      table.insert(result, formencodepart(field.name).."="..formencodepart(field.value));
    end
  else -- Unordered map of name -> value
    for name, value in pairs(form) do
      table.insert(result, formencodepart(name).."="..formencodepart(value));
    end
  end
  return table.concat(result, "&");
end

function form.decode(s)
  if not s:match("=") then return urldecode(s); end
  local r = {};
  for k, v in s:gmatch("([^=&]*)=([^&]*)") do
    k, v = k:gsub("%+", "%%20"), v:gsub("%+", "%%20");
    k, v = urldecode(k), urldecode(v);
    table.insert(r, { name = k, value = v });
    r[k] = v;
  end
  return r;
end

return {
  url = url,
  form = form,
}
