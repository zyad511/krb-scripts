print("=== KRB Loader: Checking Map... ===")

local placeId = game.PlaceId
local gameId = game.GameId

-- ماب SELL LEMON
if placeId == 79268393072444 or gameId == 79268393072444 then
    print("تم تشغيل سكربت: SELL LEMON")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zyad511/krba/refs/heads/main/KRB%20Hub.lua"))()

-- ماب Broken blade
elseif placeId == 97387256206808 or gameId == 97387256206808 then
    print("تم تشغيل سكربت: Broken blade")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/krb511/krb--/refs/heads/Scriptmain/Broken-blade-KRB-Hub.lua"))()

-- ماب Zombie survival arena
elseif placeId == 114204398207377 or gameId == 114204398207377 then
    print("تم تشغيل سكربت: Zombie survival arena")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zyad511/krb-scripts/refs/heads/main/KRB%20ZSA.lua"))()
    
else
    
    print("الماب الحالي غير مدعوم!")
    print("الـ PlaceId الحقيقي هو: " .. tostring(placeId))
    print("الـ GameId الحقيقي هو: " .. tostring(gameId))
end
