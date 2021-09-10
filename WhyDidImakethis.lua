local getgenv = getgenv;
getgenv().Toggle = true; — using _G. In synaspe returns the exploits global env but I like getgenv more
local game = game;

local GetService = game.GetService;
local wait = task.wait;
local Vector3_New = Vector3.new;
local CFrame_New = CFrame.new;
local pairs = pairs;

local Players = GetService(game,”Players”);
local workspace = GetService(game, “Workspace”); — namecall better for consistency

local Player = Players.LocalPlayer;
local Character = Player.Character;
local HumanoidRootPart = Character.HumanoidRootPart or Character.PrimaryPart;


local Pickups = workspace.Pickups;
local CoinString = “Coin”;
local GemString = “Gem”;

local VectorOffset = Vector_New(0,5,0);

local PickupsGetChildren = Pickups.GetChildren
while getgenv().Toggle do
  for Index,Variable in pairs (PickupsGetChildren(Pickups)) do
    local VariableFindFirstChild = Variable.FindFirstChild;
    local VariableName = Variable.Name;

    If (VariableName == CoinString and VariableFindFirstChild(Variable,CoinString) or VariableName == GemString and VariableFindFirstChild(Variable,GemString)) then

      local Position = Variable[VariableName].Position;

      HumanoidRootPart.CFrame = CFrame_New(Position) + VectorOffset; — you don’t need to use a different data type here but I kept it in in order of consistency

      end;
      wait();
end;
