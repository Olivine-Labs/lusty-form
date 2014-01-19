local http = require 'lusty-form.util.http'

return {
  handler = function(context)
    context.input = http.form.decode(context.request.body)
  end,

  options = {
    predicate = function(context)
      if config.default then
        return true
      end

      local content = context.request.headers["content-type"]

      if context.request.body then
        if content then
          return content == "application/x-www-form-urlencoded"
        else
          return true
        end
      end

      return false
    end
  }
}
