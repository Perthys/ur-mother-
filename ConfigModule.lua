local game = game;
local GetService = game.GetService;

local HttpService = GetService(game, "HttpService");

local JSONDecode = HttpService.JSONDecode;
local JSONEncode = HttpService.JSONEncode;

local PlaceId = game.PlaceId;

local isfolder, isfile = isfolder, isfile;
local makefile, makefolder = makefile, makefolder

local FolderString = "ImperiumStorage"

local function Init()
    local Folder = isfolder(FolderString) or makefolder(FolderString)
end

local function GetConfig(gameid)
   local File = isfile(("%s/%s.json"):format(FolderString, gameid)) or isfile(("%s/%s.json"):format(FolderString, gameid)) 
end

local function SaveConfig(ConfigName,GameId, Table)
    Init()

    


end
