-- Decompiled with Potassium's decompiler.

local LocalPlayer = game.Players.LocalPlayer;
local script_Parent = script.Parent;
local Cmds = script_Parent.Cmds;
local UserInputService = game:GetService("UserInputService");
local u1 = false;

local function toggle() -- Line: 9
    -- upvalues: script_Parent (copy), u1 (ref), UserInputService (copy)
    if script.Parent.Enabled then
        if script.Parent.ScrollFrame.Visible == true then
            script.Parent.ScrollFrame.Visible = false;
            script_Parent.Bg.ZIndex = 1;

            return;
        end;

        script.Parent.Enabled = false;

        if u1 then
            game.Players.LocalPlayer.PlayerGui.Menew.Enabled = true;
            u1 = false;
        end;
    elseif (game.Players.LocalPlayer:FindFirstChild("IsAdmin") and not game.Players.LocalPlayer:FindFirstChild("IsYoutuber") or (game.ReplicatedStorage.VIPSID.Value == game.Players.LocalPlayer.UserId or game:GetService("RunService"):IsStudio())) and not UserInputService:GetFocusedTextBox() then
        script.Parent.Enabled = true;

        if UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 or UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad2 then
            if game.Players.LocalPlayer.PlayerGui.Menew.Enabled == true then
                u1 = true;
                game.Players.LocalPlayer.PlayerGui.Menew.Enabled = false;

                return;
            end;

            u1 = false;
        end;
    end;
end;

local function createbutton() -- Line: 40
    local TextButton = Instance.new("TextButton");
    TextButton.BorderSizePixel = 0;
    TextButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
    TextButton.TextStrokeTransparency = 0;
    TextButton.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextButton.Font = Enum.Font.GothamBold;
    TextButton.TextScaled = true;

    return TextButton;
end;

local u2 = { 3297292734, 3297300386, 3297306232, 3276260413, 3276268030 };

local function canRunCommands(p3: userdata) -- Line: 52
    -- upvalues: u2 (copy)
    return p3.UserId == game.ReplicatedStorage.VIPSID.Value and true or (game.ReplicatedStorage.VIPSID.Value == 52187831 and table.find(u2, p3.UserId) and true or false);
end;

function valid()
    -- upvalues: u2 (copy)
    if not game.Players.LocalPlayer:FindFirstChild("IsAdmin") then
        local LocalPlayer2 = game.Players.LocalPlayer;

        if LocalPlayer2.UserId ~= game.ReplicatedStorage.VIPSID.Value and (game.ReplicatedStorage.VIPSID.Value ~= 52187831 or not table.find(u2, LocalPlayer2.UserId)) and not game:GetService("RunService"):IsStudio() then
            return false;
        end;
    end;

    return true;
end;

function input(p4, p5)
    -- upvalues: toggle (copy)
    if valid() == true and p5 == Enum.UserInputState.Begin then
        toggle();
    end;
end;

function scale()
    local Y = script.Parent.Parent:WaitForChild("Menew").AbsoluteSize.Y;
    local math_ceil_ret = math.ceil(Y * 0.08);
    local math_ceil_ret2 = math.ceil(Y * 0.06);
    script.Parent.Cmds.Buttons.UIGridLayout.CellSize = UDim2.new(script.Parent.Cmds.Buttons.UIGridLayout.CellSize.X.Scale, 0, 0, math_ceil_ret);
    script:WaitForChild("UIGridLayout");
    script.UIGridLayout.CellSize = UDim2.new(script.UIGridLayout.CellSize.X.Scale, 0, 0, math_ceil_ret2);
end;

scale();

if valid() == true then
    local PrivateServer = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Menew_Main"):WaitForChild("LowerBoxR"):WaitForChild("PrivateServer");
    PrivateServer.Visible = true;
    PrivateServer.MouseButton1Click:Connect(function() -- Line: 96
        input(nil, Enum.UserInputState.Begin);
    end);
end;

if valid() == true or game:GetService("UserInputService").TouchEnabled == false then
    game:GetService("ContextActionService"):BindAction("VIPbind", input, true, Enum.KeyCode.L);
    spawn(function() -- Line: 103
        task.wait(2);

        if game:GetService("UserInputService").TouchEnabled then
            local Button = game:GetService("ContextActionService"):GetButton("VIPbind");

            if not Button then
                repeat
                    task.wait(0.5);
                    Button = game:GetService("ContextActionService"):GetButton("VIPbind");
                until Button;
            end;

            if not Button then
                return Enum.ContextActionResult.Pass;
            end;

            Button.Parent.Position = UDim2.new(0.9, 0, 0, 0);
            Button.Position = UDim2.new(0, 0, 0, 0);
            Button.ActionTitle.Text = "Server Cmds";

            return Enum.ContextActionResult.Sink;
        end;

        if game:GetService("GuiService"):IsTenFootInterface() then
            local XBVIP = game.Players.LocalPlayer.PlayerGui.Menew.Main.XBVIP;
            XBVIP.Visible = true;
            XBVIP.ImageLabel.MouseButton1Click:Connect(function() -- Line: 126
                input("VIPbind", Enum.UserInputState.Begin);
            end);
        end;
    end);
end;

for _, child in pairs(Cmds.Buttons:GetChildren()) do
    if child:IsA("TextButton") and child.Name ~= "Exit" then
        child.Activated:Connect(function() -- Line: 139
            -- upvalues: child (copy), script_Parent (copy), createbutton (copy), toggle (copy)
            local v6 = game.ReplicatedStorage.Functions.Zip:InvokeServer("cmd", (tostring(child)));

            if v6 then
                script_Parent.ScrollFrame:ClearAllChildren();
                script.UIGridLayout:Clone().Parent = script_Parent.ScrollFrame;
                script_Parent.Bg.ZIndex = 2;
                script_Parent.ScrollFrame.Visible = true;
                local v7 = 0;

                for _, v in pairs(v6) do
                    v7 = v7 + script.Parent.ScrollFrame.UIGridLayout.CellSize.Y.Offset + 2;
                    local u8 = createbutton();
                    u8.Name = tostring(v);
                    u8.Text = tostring(v);
                    u8.Parent = script_Parent.ScrollFrame;
                    u8.Activated:Connect(function() -- Line: 156
                        -- upvalues: u8 (copy), script_Parent (ref), toggle (ref)
                        if u8.Text ~= "Custom" then
                            game.ReplicatedStorage.Functions.Zip:InvokeServer("cmd2", u8.Text);
                        end;

                        script.Parent.ScrollFrame.Visible = false;
                        script_Parent.Bg.ZIndex = 1;

                        if u8.Text == "Custom" then
                            toggle();
                            script.Parent.Parent.CMSetup:Fire();
                        end;
                    end);
                end;

                script.Parent.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, v7);
                script.Parent.ScrollFrame.CanvasPosition = Vector2.new(0, 0);
            end;
        end);
    elseif child:FindFirstChild("TextBox") then
        child.TextBox.FocusLost:connect(function(p9) -- Line: 175
            -- upvalues: child (copy)
            if p9 and tonumber(child.TextBox.Text) then
                game.ReplicatedStorage.Functions.Zip:InvokeServer("cmd", tostring(child), { (tonumber(child.TextBox.Text)) });
            end;
        end);
    end;
end;

game.ReplicatedStorage.CurrentGrav.Changed:connect(function(p10) -- Line: 186
    -- upvalues: Cmds (copy)
    Cmds.Buttons.LowGravity.TextBox.Text = p10;
end);
game.ReplicatedStorage.wkspc.TimeScale.Changed:connect(function(p11) -- Line: 190
    -- upvalues: Cmds (copy)
    Cmds.Buttons.Timescale.TextBox.Text = p11;
end);
script.Parent.Cmds.Exit.MouseButton1Down:Connect(function() -- Line: 194
    -- upvalues: toggle (copy)
    toggle();
end);
script.Parent.Parent:WaitForChild("ToggleVIP").Event:connect(function() -- Line: 198
    -- upvalues: toggle (copy)
    toggle();
end);