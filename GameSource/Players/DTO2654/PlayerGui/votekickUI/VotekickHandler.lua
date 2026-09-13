-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local Keyboard = Enum.UserInputType.Keyboard;
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GetUsername = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("GetUsername"));
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = false;
local ImageLabel = script.Parent.ImageLabel;
UserInputService.InputBegan:Connect(function(p2, p3) -- Line: 13
    -- upvalues: u1 (ref)
    if u1 then
        if p2.KeyCode == Enum.KeyCode.I or p2.KeyCode == Enum.KeyCode.ButtonA then
            VoteYes();

            return;
        end;

        if p2.KeyCode == Enum.KeyCode.O or p2.KeyCode == Enum.KeyCode.ButtonB then
            VoteNo();
        end;
    end;
end);
UserInputService.LastInputTypeChanged:Connect(function(p4) -- Line: 22
    -- upvalues: Keyboard (ref)
    Keyboard = p4;
end);
ImageLabel.Yes.MouseButton1Click:Connect(function() -- Line: 26
    VoteYes();
end);
ImageLabel.No.MouseButton1Click:Connect(function() -- Line: 29
    VoteNo();
end);

function VoteYes(p5)
    -- upvalues: u1 (ref), ImageLabel (copy)
    u1 = false;
    ImageLabel.Yes.ImageColor3 = Color3.fromRGB(17, 125, 9);

    if not p5 then
        game.ReplicatedStorage.Events.DoVotekick:FireServer(true);
    end;
end;

function VoteNo(p6)
    -- upvalues: u1 (ref), ImageLabel (copy)
    u1 = false;
    ImageLabel.No.ImageColor3 = Color3.fromRGB(136, 39, 26);

    if not p6 then
        game.ReplicatedStorage.Events.DoVotekick:FireServer(false);
    end;
end;

local function updateNumbers(p7, p8) -- Line: 48
    -- upvalues: Keyboard (ref), ImageLabel (copy)
    if Keyboard == Enum.UserInputType.Gamepad1 then
        ImageLabel.Yes.Votes.Text = "YES (A)" .. ": " .. p7;
        ImageLabel.No.Votes.Text = "NO (B)" .. ": " .. p8;

        return;
    end;

    if Keyboard == Enum.UserInputType.Touch then
        ImageLabel.Yes.Votes.Text = "YES" .. ": " .. p7;
        ImageLabel.No.Votes.Text = "NO" .. ": " .. p8;

        return;
    end;

    ImageLabel.Yes.Votes.Text = "YES (I)" .. ": " .. p7;
    ImageLabel.No.Votes.Text = "NO (O)" .. ": " .. p8;
end;

function ShowVotekick(p9, p10, p11, p12)
    -- upvalues: LocalPlayer (copy), RunService (copy), ImageLabel (copy), GetUsername (copy), u1 (ref), Keyboard (ref)
    if LocalPlayer:FindFirstChild("China") then
        return;
    end;

    if p9 == LocalPlayer.Name and not RunService:IsStudio() then
        return;
    end;

    ImageLabel.ImageLabel.Voter.Text = "VOTER: " .. GetUsername.GetNameToShow(p12);
    ImageLabel.ImageLabel.Reason.Text = "REASON: " .. p10:upper();
    ImageLabel.ImageLabel.Kick.Text = "KICK: " .. GetUsername.GetNameToShow(p9);
    ImageLabel.Parent.Enabled = true;
    u1 = true;
    ImageLabel.Yes.ImageColor3 = Color3.fromRGB(63, 63, 63);
    ImageLabel.No.ImageColor3 = Color3.fromRGB(63, 63, 63);

    if Keyboard == Enum.UserInputType.Gamepad1 then
        ImageLabel.Yes.Votes.Text = "YES (A)" .. ": " .. 0;
        ImageLabel.No.Votes.Text = "NO (B)" .. ": " .. 0;
    elseif Keyboard == Enum.UserInputType.Touch then
        ImageLabel.Yes.Votes.Text = "YES" .. ": " .. 0;
        ImageLabel.No.Votes.Text = "NO" .. ": " .. 0;
    else
        ImageLabel.Yes.Votes.Text = "YES (I)" .. ": " .. 0;
        ImageLabel.No.Votes.Text = "NO (O)" .. ": " .. 0;
    end;

    if LocalPlayer.Name == p11 or LocalPlayer.Name == p12 then
        VoteYes(true);
    end;

    wait(15);
    ImageLabel.Parent.Enabled = false;
    u1 = false;
end;

game.ReplicatedStorage.Events.PromptVotekick.OnClientEvent:Connect(ShowVotekick);
game.ReplicatedStorage.Events.VotekickNumbers.OnClientEvent:connect(updateNumbers);