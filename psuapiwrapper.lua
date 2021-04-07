
local Script = {}
function Script.new(...)
    local args = {...}
    if #args > 1 then
      return warn "Invalid Argument Ammount"
    end
    Script.__index = function()
          return args[1]
    end
    
    return {code = args[1], Obfuscate = function(self, options)
        
    if not args[1] then
        return warn"No Script Provided"
    elseif getgenv().key == nil then
        return warn"No Key Provided"
    elseif not options then
        warn"No option table passed using default options"
    end
    local HttpService = game:GetService("HttpService")
    local jew = "https://api.psu.dev/obfuscate"
    local msg = {
        ["script"] = "print('Hello World!')",
        ["key"] = "",
        ["options"] = {
            ["DisableSuperOperators"] = false,
            ["MaximumSecurityEnabled"] = false,
            ["EncryptAllStrings"] = false,
            ["DisableAllMacros"] = false,
            ["EnhancedOutput"] = false,
            ["CompressedOutput"] = false,
            ["PremiumFormat"] = false,
            ["ByteCodeMode"] = "Default"
        }
    }
    
    msg["script"] = args[1]
    msg["key"] = getgenv().key
    if options then
         warn"table"
        msg["options"] = options
    end
    
    local response =
        syn.request(
        {
            Url = jew, 
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json" 
            },
            Body = HttpService:JSONEncode(msg)
        }
    )
    return HttpService:JSONDecode(response.Body)["data"]

    end
    };
end

return  {
    script = Script;
};
