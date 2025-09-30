-- Copyright (c) 2025 :GutHub Sky-Stars-Air-Yaxcess :YouTube my main channel Star_Space_Galaxy my second channel Star_Space_Local_Yaxcess my third channel Star_Y_1_Pro License GNU General Public License v3.0 (GPL-3.0) Do not remove this header. All rights reserved under GNU General Public License v3.0 (GPL-3.0) and Copyright violation (c) 2025 Sky-Stars-Air-Yaxcess my main channel Star_Space_Galaxy my second channel Star_Space_Local_Yaxcess my third channel Star_Y_1_Pro

-- My contact information: Gmail email address. y8068723@gmail.com

-- This script was created for educational purposes only. Users are solely responsible for how they use it. We respect developers and urge them to fix vulnerabilities. Our goal is not to cause harm, but to promote fair and secure gameplay!

--the clowns I have never stolen anything from anyone. If you see something similar, it means either someone actually stole from me, or it is a coincidence that it looks alike. It's also possible that we use the same work logic and code, which does not mean I have stolen anything.

local isScriptRunning = true
local isMenuVisible = false

function isUTF16(utf16)
  local stringTag
  local addressJump
  if utf16 == true then
    stringTag = ';'
    addressJump = 2
  else
    stringTag = ':'
    addressJump = 1
  end
  return stringTag, addressJump
end

function setNewName()
  local stringTag, addressJump = isUTF16(playername[2])
  local t = gg.getResults(gg.getResultsCount())
  local replaceString = {}
  local stringSize = {}
  local str = {}
  gg.clearResults()
  for i= 1, #editname[1] do
    str[i] = string.sub(editname[1], i, j)
  end
  for i = 1, #t do
    stringSize[#stringSize + 1] = {address = t[i].address - 0x4, flags = gg.TYPE_WORD}
    for charCount = 1, #editname[1] do
      replaceString[#replaceString + 1] = {address = t[i].address, flags = gg.TYPE_WORD, value = string.byte(string.sub(str[charCount], 1, 1))}
      t[i].address = t[i].address + addressJump
    end
  end
  stringSize = gg.getValues(stringSize)
  for i, v in ipairs(stringSize) do
    if v.value == #playername[1] then
      v.value = #editname[1]
    end
  end
  gg.setValues(stringSize)
  gg.setValues(replaceString)
  gg.toast('String Edit Successfully')
end

function findName()
  local stringTag, addressJump = isUTF16(playername[2])
  gg.searchNumber(stringTag..playername[1])
  local a = gg.getResults(gg.getResultsCount())
  if #a == 0 then
    gg.toast('String Not Found')
  else
    local stringLength = #playername[1]
    for i = 1, stringLength do
      gg.refineNumber(stringTag..string.sub(playername[1], 1, stringLength)) 
      stringLength = stringLength - 1
    end
    prompt_edit()
  end
end

function noselect()
  gg.toast('Cancel')
end

function prompt_edit()
  editname = gg.prompt(
    {[1] = 'Write String'},
    {[1] = '0'},
    {[1] = 'text'})
  if editname == nil then 
    noselect()
    gg.clearResults()
  else
    setNewName()
  end
end

function prompt_search()
  playername = gg.prompt(
    {[1] = 'Write String' ,[2] = 'FOR TYPE STRING UTF-16'},
    {[1] = '0'          ,[2] = false},
    {[1] = 'text'       ,[2] = 'checkBox'})
  if playername == nil then
    noselect()
  else
    findName()
  end
end

function exitScript()
  local result = gg.alert("Do you want to exit script?", "Exit", "Cancel")
  if result == 1 then
    isScriptRunning = false
  elseif result == 2 then
    gg.clearResults()
  end
end

function mainMenu()
  local result = gg.choice({"Start Search Script", "Exit Script"}, nil, "Choose an option")
  if result == 1 then
    prompt_search()
  elseif result == 2 then
    exitScript()
  else
    gg.toast("Invalid Option!")
  end
end

while (isScriptRunning) do
  if gg.isVisible() then
    gg.setVisible(false)
    mainMenu()
  end
  gg.sleep(200)
end