started = 0
our_id = 0
function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function vardump(value, depth, key)
  local linePrefix = ""
  local spaces = ""
  
  if key ~= nil then
    linePrefix = "["..key.."] = "
  end
  
  if depth == nil then
    depth = 0
  else
    depth = depth + 1
    for i=1, depth do spaces = spaces .. "  " end
  end
  
  if type(value) == 'table' then
    mTable = getmetatable(value)
    if mTable == nil then
      print(spaces ..linePrefix.."(table) ")
    else
      print(spaces .."(metatable) ")
        value = mTable
    end		
    for tableKey, tableValue in pairs(value) do
      vardump(tableValue, depth, tableKey)
    end
  elseif type(value)	== 'function' or 
      type(value)	== 'thread' or 
      type(value)	== 'userdata' or
      value		== nil
  then
    print(spaces..tostring(value))
  else
    print(spaces..linePrefix.."("..type(value)..") "..tostring(value))
  end
end

print ("HI, this is lua script")

function ok_cb(extra, success, result)
end


function on_msg_receive (msg)
  if (string.lower(msg.text) == '/eten!' or string.lower(msg.text) == '/voedertijd!') then
      if (msg.date > os.time()-600) then
        if (tonumber(os.date('%H')) < 8) then
          send_msg (msg.to.print_name, 'Vind je dit zelf gepast?', ok_cb, false)
        else
          os.execute('/usr/bin/lua /home/pi/signal1.lua')
          if (tonumber(os.date('%H')) > 18 and tonumber(os.date('%i')) > 30) then
            send_msg (msg.to.print_name, 'Nou, je heb er wel de tijd voor genomen', ok_cb, false)
          end
        end
      end 
  end

  if (string.sub(string.lower(msg.text), 0, 4) == '/sos') then
      if (msg.date > os.time()-600) then
        os.execute('/usr/bin/lua /home/pi/sos.lua')
      end
  end
  if (string.lower(msg.text) == '/lunch!' or string.lower(msg.text) == '/snijplanktijd!') then
      if (msg.date > os.time()-60) then
        if (tonumber(os.date('%H')) < 8) then
          send_msg (msg.to.print_name, 'Vind je dit zelf gepast?', ok_cb, false)
        else
          os.execute('/usr/bin/lua /home/pi/signal3.lua')
        end
      end
  end
  if (string.sub(string.lower(msg.text), 0, 13) == '/gezelligheid') then
      if (msg.date > os.time()-60) then
        if (tonumber(os.date('%H')) < 8) then
          send_msg (msg.to.print_name, 'Vind je dit zelf gepast?', ok_cb, false)
        else
          os.execute('/usr/bin/lua /home/pi/signal4.lua')
          if (string.find(string.lower(msg.text), 'bier', 1) ~= nil) then
            send_msg (msg.to.print_name, 'Jaa bier!!', ok_cb, false)
          end
        end
      end
  end
  if (string.sub(string.lower(msg.text), 0, 3) == '/hj') then
      if (msg.date > os.time()-60) then
        if (tonumber(os.date('%H')) < 8) then
          send_msg (msg.to.print_name, 'Vind je dit zelf gepast?', ok_cb, false)
        else
          os.execute('/usr/bin/lua /home/pi/signal5.lua')
        end
      end
  end
  if (string.lower(msg.text) == 'Dankjewel blauwemap!') then
	send_msg (msg.to.print_name, 'Graag gedaan!', ok_cb, false)
  end
  if (string.sub(string.lower(msg.text), -10) == '> eetlijst') then
        os.execute('/usr/bin/python /home/pi/python-eetlijst/examples/noticeboard.py partyzone bassment prepend "' .. string.sub(msg.text, 0, -12) ..'"')
       -- send_msg (msg.to.print_name, 'Toegevoegd aan eetlijst', ok_cb, false)
  end
  if (msg.text == '') then
        send_msg (msg.to.print_name, 'Graag gedaan!', ok_cb, false)
  end
  if (string.match(string.lower(msg.text), "al vrijdag?")) then
    if (tonumber(os.date('%w')) == 5) then
      send_msg (msg.to.print_name, 'Ja!', ok_cb, false)
    else
      send_msg (msg.to.print_name, 'Nee.', ok_cb, false)
    end
  end
  if (string.match(string.lower(msg.text), "rotterdam") and msg.text ~= "Mooi Rotterdam!") then
    send_msg (msg.to.print_name, 'Mooi Rotterdam!', ok_cb, false)
  end
  if (string.match(string.lower(msg.text), "amsterdam") and msg.text ~= "Mooi Rotterdam!") then
    send_msg (msg.to.print_name, '020', ok_cb, false)
  end

  if (string.match(string.lower(msg.text), "sjonnie")) then
    send_msg (msg.to.print_name, 'Het is Johnny.', ok_cb, false)
  end
  if (string.match(string.lower(msg.text), "waarom niet?")) then
    send_msg (msg.to.print_name, 'Omdat ik dat zeg, en dat is voldoende.', ok_cb, false)
  end
  if (string.lower(msg.text) == '/fortune') then
    send_msg (msg.to.print_name, os.capture('/usr/games/fortune -s'), ok_cb, false)
  end
  if (string.match(string.lower(msg.text), "hoe laat is het")) then
    if (tonumber(os.date('%H')) > 21 or tonumber(os.date('%H')) < 4) then
      send_msg (msg.to.print_name, "Frituur!", ok_cb, false)
    elseif (tonumber(os.date('%H')) > 14 and string.match(os.capture('wget -q -O - "$@" http://www.kanikeenkortebroekaan.nl/'), "ja.png")) then
      send_msg (msg.to.print_name, "Strandstoeltijd!", ok_cb, false)
    else
      send_msg (msg.to.print_name, os.date('%H') .. ":" .. os.date('%M'), ok_cb, false)
    end
  end
  if (string.match(string.lower(msg.text), "doe eens niet")) then
    send_msg (msg.to.print_name, "Ja, hou eens op daarmee", ok_cb, false)
  end
  if (string.match(string.lower(msg.from.last_name), "garret")) then
    send_msg (msg.to.print_name, "Houd je bek slet!", ok_cb, false)
  end  
  if (string.match(string.lower(msg.text), "tilburg")) then
    send_msg (msg.to.print_name, "Kutstad", ok_cb, false)
  end 
  if (string.match(string.lower(msg.text), "korte broek aan")) then
    if (string.match(os.capture('wget -q -O - "$@" http://www.kanikeenkortebroekaan.nl/'), "ja.png")) then 
      send_msg (msg.to.print_name, 'Ja!', ok_cb, false)
    else
      send_msg (msg.to.print_name, 'Nee.', ok_cb, false)
    end
  end  
  if (string.match(string.lower(msg.text), "gezelligheid")) then
    if (string.match(os.capture('wget -q -O - "$@" http://192.168.1.177/api/statusinfo?_=1411731041081'), '"inStandby": "true"')) then 
      os.capture('wget -q -O - "$@" http://192.168.1.177/api/powerstate?newstate=0&_=1411730562394')
    end
    os.capture('wget -q -O - "$@" http://192.168.1.177/api/zap?sRef=1%3A0%3A1%3A33AD%3A3EB%3A1%3AC00000%3A0%3A0%3A0%3A&_=1411729693277')
    os.capture('wget -q -O - "$@" http://192.168.1.177/web/vol?set=set100&_=1411729861333')
    send_msg (msg.to.print_name, 'Jajajaja!', ok_cb, false)
  end
  --print ( "Message # " .. msg.id .. " (flags " .. msg.flags .. ")")
vardump(msg)
end


function on_our_id (id)
  our_id = id
end

function on_user_update (user, what)
  --vardump (user)
end

function on_chat_update (chat, what)
  --vardump (chat)
end

function on_secret_chat_update (schat, what)
  --vardump (schat)
end

function on_get_difference_end ()
end

function on_binlog_replay_end ()
  started = 1
end



