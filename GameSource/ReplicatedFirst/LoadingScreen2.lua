-- Decompiled with Potassium's decompiler.

task.spawn(function() -- Line: 5
    local StarterGui = game:GetService("StarterGui");
    local v1;

    repeat
        v1 = pcall(function() -- Line: 9
            -- upvalues: StarterGui (copy)
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false);
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
            StarterGui:SetCore("TopbarEnabled", false);
        end);
        task.wait(0.5);
    until v1;
end);

local function yieldWithTimeout(p2: userdata, p3: number) -- Line: 20
    local coroutine_running_ret = coroutine.running();
    local u4 = nil;
    u4 = p2:Connect(function(...) -- Line: 23
        -- upvalues: u4 (ref), coroutine_running_ret (copy)
        if u4 == nil then
            return;
        end;

        u4:Disconnect();
        u4 = nil;
        task.spawn(coroutine_running_ret, false, ...);
    end);
    task.delay(p3, function() -- Line: 33
        -- upvalues: u4 (ref), coroutine_running_ret (copy)
        if u4 == nil then
            return;
        end;

        u4:Disconnect();
        u4 = nil;
        task.spawn(coroutine_running_ret, true);
    end);

    return coroutine.yield();
end;

local TweenService = game:GetService("TweenService");
local ScreenGui = script:WaitForChild("ScreenGui");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local TextLabel = ScreenGui:WaitForChild("Frame"):WaitForChild("title"):WaitForChild("TextLabel");
local Frame = TextLabel:WaitForChild("Frame");
local v5 = Frame:WaitForChild("1");
local LocaleId = LocalPlayer.LocaleId;
v5.Parent = nil;

local function giveInterface() -- Line: 55
    -- upvalues: PlayerGui (copy)
    local PlayerGui2 = game:GetService("ReplicatedStorage"):WaitForChild("PlayerGui");

    repeat
        task.wait(0.1);
    until #PlayerGui2:GetDescendants() == PlayerGui2:GetAttribute("Descendants");

    for _, child in PlayerGui2:GetChildren() do
        child.Parent = PlayerGui;
    end;
end;

local v6 = {
    ["en-us"] = "Done!"
};
local u7 = {
    {
        titles = {
            ["en-us"] = "Waiting for server..."
        },

        task = function() -- Line: 90, Name: task
            repeat
                task.wait();
            until workspace:GetAttribute("FinalServerLoad");
        end
    },
    {
        titles = {
            ["en-us"] = "Waiting for game..."
        },

        task = function() -- Line: 100, Name: task
            -- upvalues: yieldWithTimeout (copy)
            local BindableEvent = Instance.new("BindableEvent");
            task.defer(function() -- Line: 102
                -- upvalues: BindableEvent (copy)
                if not game:IsLoaded() then
                    game.Loaded:Wait();
                end;

                BindableEvent:Fire();
            end);
            yieldWithTimeout(BindableEvent.Event, 5);
        end
    },
    {
        titles = {
            ["en-us"] = "Loading interface..."
        },

        task = function() -- Line: 117, Name: task
            -- upvalues: giveInterface (copy)
            giveInterface();
        end
    },
    {
        titles = {
            ["en-us"] = "Loading components..."
        },

        task = function() -- Line: 125, Name: task
            repeat
                task.wait();
            until workspace:GetAttribute("ClientServiceInit");
        end
    },
    {
        titles = {
            ["en-us"] = "Establishing server connection..."
        },

        task = function() -- Line: 135, Name: task
            repeat
                task.wait();
            until workspace:GetAttribute("ClientServerConnected");
        end
    },
    {
        titles = {
            ["en-us"] = "Initialising services..."
        },

        task = function() -- Line: 145, Name: task
            repeat
                task.wait();
            until workspace:GetAttribute("ClientLoaded");
        end
    },
    {
        titles = {
            ["en-us"] = "Waiting for player data..."
        },

        task = function() -- Line: 155, Name: task
            -- upvalues: LocalPlayer (copy)
            repeat
                task.wait();
            until LocalPlayer:FindFirstChild("DataLoaded");
        end
    }
};
TextLabel.Text = ({
    ["en-us"] = "Loading assets..."
})[LocaleId] or "Loading assets...";
ScreenGui.Parent = PlayerGui;
local BindableEvent = Instance.new("BindableEvent");
task.defer(function() -- Line: 190
    -- upvalues: ScreenGui (copy), BindableEvent (copy)
    game:GetService("ContentProvider"):PreloadAsync({ ScreenGui:WaitForChild("Frame"):WaitForChild("title"), ScreenGui:WaitForChild("step") });
    BindableEvent:Fire();
end);
yieldWithTimeout(BindableEvent.Event, 5);
workspace:WaitForChild("Terrain"):SetAttribute("FrameworkInit", true);
script.Parent:RemoveDefaultLoadingScreen();
local ArrivingTeleportGui = game:GetService("TeleportService"):GetArrivingTeleportGui();

if ArrivingTeleportGui then
    task.delay(0.2, function() -- Line: 201
        -- upvalues: ArrivingTeleportGui (copy)
        ArrivingTeleportGui:Destroy();
    end);
end;

if workspace:GetAttribute("FinalServerLoad") then
    table.remove(u7, 1);
end;

for i, _ in u7 do
    local v8 = v5:Clone();
    v8.Name = tostring(i);
    v8.Parent = Frame;
end;

local TweenInfo_new_ret = TweenInfo.new(0.15);

for i, v in u7 do
    local u9 = Frame:WaitForChild((tostring(i)));
    TextLabel.Text = v.titles[LocaleId] or v.titles["en-us"];
    TweenService:Create(u9.display, TweenInfo_new_ret, {
        BackgroundTransparency = 0.5
    }):Play();
    local u10 = false;
    task.spawn(function() -- Line: 226
        -- upvalues: v (copy), u10 (ref)
        v.task();
        u10 = true;
    end);
    task.spawn(function() -- Line: 232
        -- upvalues: u10 (ref), u9 (copy)
        while not u10 do
            u9.display:TweenPosition(UDim2.new(0, 0, 0.5, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.30000000000000004, true);
            task.wait(0.30000000000000004);

            if u10 then
                break;
            end;

            u9.display:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.6000000000000001, true);
            task.wait(0.6000000000000001);
        end;
    end);

    repeat
        task.wait(0.05);
    until u10;

    ScreenGui.step.PlaybackSpeed = 0.9 + 0.1 * i / #u7;
    ScreenGui.step:Play();
    TweenService:Create(u9.display, TweenInfo_new_ret, {
        BackgroundTransparency = 0
    }):Play();
    task.spawn(function() -- Line: 251
        -- upvalues: u9 (copy)
        u9.display:TweenPosition(UDim2.new(0, 0, -0.75, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.15, true);
        task.wait(0.15);
        u9.display:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true);
    end);
end;

TextLabel.Text = v6[LocaleId] or "Done!";
task.wait(0.3);
task.spawn(function() -- Line: 261
    -- upvalues: u7 (copy), Frame (copy), TweenService (copy)
    for i, _ in u7 do
        local v11 = Frame:WaitForChild((tostring(i)));
        TweenService:Create(v11.display, TweenInfo.new(0.2), {
            BackgroundTransparency = 1
        }):Play();
        v11.display:TweenPosition(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true);
        task.wait(0.06);
    end;
end);
task.wait(0.3);
TweenService:Create(ScreenGui.Frame, TweenInfo.new(0.3), {
    BackgroundTransparency = 1
}):Play();
TweenService:Create(ScreenGui.Frame.Title, TweenInfo.new(0.3), {
    ImageTransparency = 1
}):Play();
TweenService:Create(ScreenGui.Frame.DropShadow, TweenInfo.new(0.3), {
    ImageTransparency = 1
}):Play();
TweenService:Create(ScreenGui.Frame.DropShadowPerm, TweenInfo.new(0.3), {
    ImageTransparency = 1
}):Play();
TweenService:Create(ScreenGui.Frame.title.TextLabel, TweenInfo.new(0.3), {
    TextTransparency = 1
}):Play();
task.wait(2);
ScreenGui:Destroy();