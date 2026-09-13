-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
game:GetService("Lighting");
local Workspace = game:GetService("Workspace");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local TweenService = game:GetService("TweenService");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local ScriptContents = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ToT"):WaitForChild("ScriptContents");
local Parent = ScriptContents.Parent;
local Bell = ScriptContents.Bell;
local Bucket = ScriptContents.Bucket;
local Idle = ScriptContents.Idle;
local Throw = ScriptContents.Throw;
local ToTGive = ReplicatedStorage:WaitForChild("ToTGive");
local ToTGet = ReplicatedStorage:WaitForChild("ToTGet");
local ToTShop = require(ReplicatedStorage:WaitForChild("Modules").ToTShop);
local LocalPlayer = Players.LocalPlayer;
local Increase = Parent.Candy.Increase;
local u1 = 0;
local u2 = nil;
local AssetStreaming = require(ReplicatedFirst.Client.Core.AssetStreaming);
local u3 = nil;

local function BuildQuest() -- Line: 34
    -- upvalues: ToTGet (copy), u3 (ref), Parent (copy)
    local v4 = ToTGet:InvokeServer("Quest");
    u3 = v4;

    if not v4.Active then
        Parent.Active.Visible = false;

        return;
    end;

    Parent.Active.QuestName.Text = `{v4.Active}'s Quest`;

    if v4.Quests[v4.Active].Complete then
        Parent.Active.Container.Description.Text = `Quest Complete, Return to {v4.Active}!`;
    elseif v4.Quests[v4.Active].Progress.Type == "ToT" then
        local v5 = v4.Quests[v4.Active].Progress.Needed - v4.Quests[v4.Active].Progress.Finished;
        Parent.Active.Container.Description.Text = `Trick or Treat at {v5} House{v5 > 1 and "s" or ""}`;
    elseif v4.Quests[v4.Active].Progress.Type == "Clear" then
        local v6 = v4.Quests[v4.Active].Progress.Needed - v4.Quests[v4.Active].Progress.Finished;
        Parent.Active.Container.Description.Text = `Clean out {v6} House{v6 > 1 and "s" or ""}`;
    elseif v4.Quests[v4.Active].Progress.Type == "Timed" then
        local v7 = v4.Quests[v4.Active].Progress.Needed - v4.Quests[v4.Active].Progress.Finished;
        Parent.Active.Container.Description.Text = `Clean out {v7} House{v7 > 1 and "s" or ""} in under a minute each.`;
    elseif v4.Quests[v4.Active].Progress.Type == "Obby" then
        local v8 = v4.Quests[v4.Active].Progress.Needed - v4.Quests[v4.Active].Progress.Finished;
        Parent.Active.Container.Description.Text = `Complete {v8} {v8 > 1 and "Obbies" or "Obby"} inside houses.`;
    end;

    Parent.Active.Visible = true;
end;

local function Begin() -- Line: 63
    -- upvalues: ToTGet (copy), Parent (copy), ToTGive (copy), HttpService (copy), u1 (ref), Increase (copy), BuildQuest (copy), Workspace (copy), ScriptContents (copy), LocalPlayer (copy), UserInputService (copy), u3 (ref), MarketplaceService (copy), u2 (ref), ToTShop (copy), Bell (copy), TweenService (copy), AssetStreaming (copy), Bucket (copy), Idle (copy), Throw (copy), RunService (copy)
    local u9 = ToTGet:InvokeServer("Candy") or 0;
    Parent.Candy.Container.TextLabel.Text = u9;
    Parent.Enabled = true;
    ToTGive.OnClientEvent:Connect(function(p10: number) -- Line: 69
        -- upvalues: u9 (ref), HttpService (ref), u1 (ref), Increase (ref), Parent (ref), BuildQuest (ref)
        if u9 <= p10 then
            local v11 = HttpService:GenerateGUID();
            u1 = v11;
            local v12 = Increase:Clone();
            v12.Text = `+ {p10 - u9}`;
            v12.Visible = true;
            v12.Parent = Parent.Candy;
            task.wait(1);
            v12:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.15, true);
            task.wait(0.15);
            v12:Destroy();

            for i = 0, p10 - u9 do
                Parent.Candy.Container.TextLabel.Text = u9 + i;
                task.wait(0.025);

                if u1 ~= v11 then
                    break;
                end;

                local _ = i;
            end;
        else
            Parent.Candy.Container.TextLabel.Text = p10;
        end;

        u9 = p10;
        BuildQuest();
    end);
    local Map = Workspace:WaitForChild("Map");

    for _, child in Map:WaitForChild("Secret"):GetChildren() do
        if child:IsA("Model") and (child:FindFirstChild("Humanoid") and child.Humanoid:FindFirstChild("Idle")) then
            child.Humanoid:LoadAnimation(child.Humanoid.Idle):Play();
        end;
    end;

    local v13 = ToTGet:InvokeServer("Quest");

    for _, child in Map:WaitForChild("NPCs"):GetChildren() do
        local Info = require(child.Info);
        local Animation = Instance.new("Animation");
        Animation.AnimationId = Info.Idle;
        child.Humanoid:LoadAnimation(Animation):Play();
        local v14 = ScriptContents.Prompt:Clone();
        v14.ActionText = "Speak";
        v14.ObjectText = child.Name;

        if v13.Quests[child.Name] and v13.Quests[child.Name].Returned then
            child.HumanoidRootPart.Alert.Enabled = false;
        end;

        v14.Triggered:Connect(function(p15: userdata) -- Line: 123
            -- upvalues: LocalPlayer (ref), Info (copy), ToTGet (ref), child (copy), Parent (ref), UserInputService (ref), u3 (ref), MarketplaceService (ref), u2 (ref)
            if LocalPlayer ~= p15 then
                return;
            end;

            if not Info.Quest then
                Parent.Shop.Visible = true;
                UserInputService.MouseIconEnabled = true;

                return;
            end;

            local Description = Info.Quest.Description;
            local v16 = ToTGet:InvokeServer("Quest");

            if v16.Active then
                if v16.Active == child.Name then
                    if ToTGet:InvokeServer("CheckQuest") then
                        Description = Info.Quest.Complete;
                        child.HumanoidRootPart.Alert.Enabled = false;

                        if Info.Quest.Reward.Item <= 0 then
                            return;
                        end;

                        Parent.Reward.Container.Rewards.List.Giver.Text = `You've earned the {child.Name} Bloxikin.`;
                        Parent.Reward.Container.Rewards.List.Item.CurrencyIcon.Image = `rbxthumb://type=Asset&id={Info.Quest.Reward.Item}&w=420&h=420`;
                        Parent.Reward.Visible = true;
                        UserInputService.MouseIconEnabled = true;
                    else
                        Description = "You already have my quest! Please complete it and speak to me again!";
                    end;
                else
                    Description = "It seems you already have someone else\'s quest please complete it then come speak to me again!";
                end;
            end;

            local v17 = v16.Quests[child.Name] and v16.Quests[child.Name].Returned and "Thanks for finishing my quest!" or Description;

            if v17 == Info.Quest.Description then
                Parent.Quest.Container.Buttons.Decline.TextShadow.Label.Text = "DECLINE";
                Parent.Quest.Container.Buttons.Decline.TextShadow.Text = "DECLINE";
                Parent.Quest.Container.Buttons.Accept.Visible = true;
            else
                Parent.Quest.Container.Buttons.Decline.TextShadow.Label.Text = "CLOSE";
                Parent.Quest.Container.Buttons.Decline.TextShadow.Text = "CLOSE";
                Parent.Quest.Container.Buttons.Accept.Visible = false;
            end;

            Parent.Quest.Container.Rewards.List.Candy.Amount.Text = Info.Quest.Reward.Candy;
            Parent.Quest.Container.Rewards.List.Bloxikin.CurrencyIcon.Image = `rbxthumb://type=Asset&id={Info.Quest.Reward.Item}&w=420&h=420`;
            Parent.Quest.Container.Rewards.List.Bloxikin.Visible = Info.Quest.Reward.Item > 0;
            local Accept = Parent.Quest.Container.Rewards.List.Bloxikin.Accept;
            local v18;

            if Info.Quest.Reward.Item > 0 then
                v18 = u3.Quests[child.Name] and (u3.Quests[child.Name].Returned and not MarketplaceService:PlayerOwnsAsset(LocalPlayer, Info.Quest.Reward.Item)) and not MarketplaceService:PlayerOwnsAsset(LocalPlayer, Info.Quest.Reward.Backup);
            else
                v18 = false;
            end;

            Accept.Visible = v18;
            Parent.Quest.Container.Top.Giver.Text = child.Name;
            Parent.Quest.Container.Top.Dialog.Text = v17;
            Parent.Quest.Visible = true;
            UserInputService.MouseIconEnabled = true;
            u2 = child;
        end);
        v14.Parent = child.HumanoidRootPart;
    end;

    Parent.Reward.Container.Buttons.Decline.MouseButton1Down:Connect(function() -- Line: 183
        -- upvalues: Parent (ref)
        Parent.Reward.Visible = false;
    end);
    Parent.Quest.Container.Buttons.Decline.MouseButton1Down:Connect(function() -- Line: 187
        -- upvalues: Parent (ref)
        Parent.Quest.Visible = false;
    end);
    Parent.Quest.Container.Rewards.List.Bloxikin.Accept.MouseButton1Down:Connect(function() -- Line: 191
        -- upvalues: ToTGet (ref), u2 (ref), Parent (ref)
        if ToTGet:InvokeServer("UGC", u2) then
            Parent.Quest.Container.Rewards.List.Bloxikin.Accept.Visible = false;
        end;
    end);
    Parent.Quest.Container.Buttons.Accept.MouseButton1Down:Connect(function() -- Line: 198
        -- upvalues: ToTGet (ref), u2 (ref), Parent (ref), BuildQuest (ref)
        ToTGet:InvokeServer("AcceptQuest", u2);
        Parent.Quest.Visible = false;
        BuildQuest();
    end);
    local v19 = Parent.Shop.Container.Rewards.List.Template:Clone();
    Parent.Shop.Container.Rewards.List.Template:Destroy();

    for i, v in ToTShop do
        local v20 = v19:Clone();
        v20.LayoutOrder = v.Price;
        v20.Amount.Text = v.Price;
        v20.CurrencyIcon.Image = `rbxthumb://type=Asset&id={v.Item}&w=420&h=420`;
        v20.Parent = Parent.Shop.Container.Rewards.List;
        v20.CurrencyIcon.MouseButton1Down:Connect(function() -- Line: 214
            -- upvalues: ToTGet (ref), i (copy), Parent (ref)
            if ToTGet:InvokeServer("Shop", i) then
                Parent.Shop.Checkmark.Visible = true;
                task.wait(1);
                Parent.Shop.Checkmark.Visible = false;
            end;
        end);
    end;

    Parent.Shop.Container.Buttons.Decline.MouseButton1Down:Connect(function() -- Line: 225
        -- upvalues: Parent (ref)
        Parent.Shop.Visible = false;
    end);

    for _, child in Map:WaitForChild("Houses"):GetChildren() do
        child.Door.Door.Prompt.Triggered:Connect(function(p21: userdata) -- Line: 230
            -- upvalues: LocalPlayer (ref), ToTGet (ref), child (copy), Bell (ref), TweenService (ref), AssetStreaming (ref), Bucket (ref), Idle (ref), Throw (ref), Workspace (ref)
            if LocalPlayer ~= p21 then
                return;
            end;

            local u22 = ToTGet:InvokeServer("Ring", child);
            child.Door.Door.Prompt.Enabled = false;
            child.Door.Door.Ding.ExtentsOffsetWorldSpace = Vector3.new(0, 0, -3);
            child.Door.Door.Dong.ExtentsOffsetWorldSpace = Vector3.new(0, 0, -3);
            Bell:Play();
            child.Door.Door.Ding.Enabled = true;
            local Ding = child.Door.Door.Ding;
            local TweenInfo_new_ret = TweenInfo.new(0.825, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
            local v23 = {};
            local math_random_ret = math.random(-1, 1);
            v23.ExtentsOffsetWorldSpace = Vector3.new(1.25, math_random_ret, -3);
            local v24 = TweenService:Create(Ding, TweenInfo_new_ret, v23);
            v24:Play();
            task.delay(0.825, function() -- Line: 245
                -- upvalues: child (ref)
                child.Door.Door.Ding.Enabled = false;
            end);
            task.wait(0.4);
            child.Door.Door.Dong.Enabled = true;
            local Dong = child.Door.Door.Dong;
            local TweenInfo_new_ret2 = TweenInfo.new(0.825, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
            local v25 = {};
            local math_random_ret2 = math.random(-1, 1);
            v25.ExtentsOffsetWorldSpace = Vector3.new(1.25, math_random_ret2, -3);
            local v26 = TweenService:Create(Dong, TweenInfo_new_ret2, v25);
            v26:Play();

            if typeof(u22) == "string" then
                local Asset = AssetStreaming.GetAsset(u22, "ChrModels", true);

                if not Asset:FindFirstChild("HumanoidRootPart") then
                    Asset = AssetStreaming.GetAsset("Froggy", "ChrModels", true);
                end;

                if Asset:FindFirstChild("HumanoidRootPart") then
                    Asset.HumanoidRootPart.Anchored = true;
                    Asset:SetPrimaryPartCFrame(child.Giver.CFrame);
                    Asset.Parent = child;
                    local v27 = Bucket:Clone();
                    v27.Parent = Asset;
                    v27.Weld.Part1 = Asset.LeftHand;
                    local v28 = Asset.Humanoid:LoadAnimation(Idle);
                    local u29 = Asset.Humanoid:LoadAnimation(Throw);
                    v28:Play();
                    local v30 = { "Torso", "LeftArm", "RightArm", "LeftLeg", "RightLeg" };
                    local Color = BrickColor.new("Bright blue").Color;
                    local v31 = Asset:FindFirstChild("Body Colors");

                    if v31 then
                        for _, v in v30 do
                            if v31[v .. "Color"] == BrickColor.new("Hot pink") then
                                v31[v .. "Color3"] = Color;
                            end;
                        end;
                    end;

                    for _, child2 in Asset:GetChildren() do
                        if child2:IsA("Accoutrement") and child2:FindFirstChild("Handle") then
                            if child2.Handle.BrickColor == BrickColor.new("Hot pink") then
                                child2.Handle.Color = Color;
                            elseif child2.Handle:FindFirstChild("teamoverlay") then
                                child2.Handle.teamoverlay.Color3 = Color;
                            elseif child2.Handle:FindFirstChild("Mesh") and (child2.Handle.Mesh.VertexColor.X ~= child2.Handle.Mesh.VertexColor.Y or (child2.Handle.Mesh.VertexColor.X ~= child2.Handle.Mesh.VertexColor.Z or child2.Handle.Mesh.VertexColor.Y ~= child2.Handle.Mesh.VertexColor.Z)) then
                                child2.Handle.Mesh.VertexColor = Vector3.new(Color.R, Color.G, Color.B);
                            elseif child2.Handle:FindFirstChild("SpecialMesh") and (child2.Handle.SpecialMesh.VertexColor.X ~= child2.Handle.SpecialMesh.VertexColor.Y or (child2.Handle.SpecialMesh.VertexColor.X ~= child2.Handle.SpecialMesh.VertexColor.Z or child2.Handle.SpecialMesh.VertexColor.Y ~= child2.Handle.SpecialMesh.VertexColor.Z)) then
                                child2.Handle.SpecialMesh.VertexColor = Vector3.new(Color.R, Color.G, Color.B);
                            end;
                        elseif child2:IsA("MeshPart") and child2.BrickColor == BrickColor.new("Hot pink") then
                            child2.Color = Color;
                        end;
                    end;

                    task.delay(1.35, function() -- Line: 300
                        -- upvalues: u29 (copy)
                        u29:Play();
                    end);
                end;

                local CFrame2 = child.Door.Hinge.CFrame;
                local u32 = TweenService:Create(child.Door.Hinge, TweenInfo.new(1.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                    CFrame = CFrame2 * CFrame.Angles(-2.181661564992912, 0, 0)
                });
                u32:Play();
                task.delay(3, function() -- Line: 311
                    -- upvalues: u32 (copy), TweenService (ref), child (ref), CFrame2 (copy), Asset (ref)
                    u32:Destroy();
                    local v33 = TweenService:Create(child.Door.Hinge, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
                        CFrame = CFrame2
                    });
                    v33:Play();
                    task.wait(0.5);
                    v33:Destroy();
                    Asset:Destroy();
                end);
            elseif u22 then
                task.delay(1.85, function() -- Line: 323
                    -- upvalues: Workspace (ref), u22 (copy)
                    Workspace.Camera.CFrame = CFrame.new(Workspace.Camera.CFrame.Position, u22.Them.Position);
                end);
            end;

            task.wait(0.825);
            child.Door.Door.Dong.Enabled = false;
            v24:Destroy();
            v26:Destroy();
            task.wait(60);
            child.Door.Door.Prompt.Enabled = true;
        end);
    end;

    BuildQuest();

    local function Overlay() -- Line: 340
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.PlayerGui.GUI.Top.Visible = false;
        LocalPlayer.PlayerGui.GUI.Timer.Text = "Witching Hour";
        LocalPlayer.PlayerGui.GUI.Timer.Font = Enum.Font.Creepster;
        LocalPlayer.PlayerGui.GUI.Timer.BackgroundTransparency = 1;
        LocalPlayer.PlayerGui.GUI.Timer.Overlay.Visible = true;
        LocalPlayer.PlayerGui.GUI.Timer.ImageLabel.Visible = false;
        LocalPlayer.PlayerGui.GUI.Timer.ImageLabel2.Visible = false;
        LocalPlayer.PlayerGui.GUI_Interface.Vitals.Ammo.Image = "";
        LocalPlayer.PlayerGui.GUI_Interface.Vitals.Ammo.Overlay.Visible = true;
    end;

    LocalPlayer:WaitForChild("Status").Team:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 353
        -- upvalues: LocalPlayer (ref), ScriptContents (ref)
        if LocalPlayer.Status.Team.Value == "Spectator" then
            ScriptContents.Music:Stop();

            return;
        end;

        ScriptContents.Music:Play();
    end);
    LocalPlayer.PlayerGui.GUI.Top:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 361
        -- upvalues: LocalPlayer (ref), Overlay (copy)
        if not LocalPlayer.PlayerGui.GUI.Top.Visible then
            return;
        end;

        Overlay();
    end);
    Overlay();
    task.delay(1, function() -- Line: 368
        -- upvalues: Overlay (copy)
        Overlay();
    end);

    local function GetActiveHouse() -- Line: 372
        -- upvalues: Map (copy), LocalPlayer (ref)
        local v34 = (1 / 0);
        local v35 = nil;

        for _, child in Map.Houses:GetChildren() do
            if child.Door.Door.Prompt.Enabled then
                local Magnitude = (LocalPlayer.Character.HumanoidRootPart.Position - child.Door.Door.Position).Magnitude;

                if Magnitude <= v34 then
                    v35 = child.Door.Door;
                    v34 = Magnitude;
                end;
            end;
        end;

        return v35;
    end;

    local function GetActiveQuest() -- Line: 388
        -- upvalues: Map (copy), u3 (ref), LocalPlayer (ref)
        local v36 = (1 / 0);
        local v37 = nil;

        for _, child in Map.NPCs:GetChildren() do
            if not u3.Quests[child.Name] and child.Name ~= "Smug Zam" then
                local Magnitude = (LocalPlayer.Character.HumanoidRootPart.Position - child.HumanoidRootPart.Position).Magnitude;

                if Magnitude <= v36 then
                    v37 = child.HumanoidRootPart;
                    v36 = Magnitude;
                end;
            end;
        end;

        return v37;
    end;

    local function TrackTarget() -- Line: 406
        -- upvalues: u3 (ref), Map (copy), GetActiveHouse (copy), GetActiveQuest (copy), Parent (ref), Workspace (ref), LocalPlayer (ref)
        local v38;

        if u3.Active then
            v38 = u3.Quests[u3.Active].Complete and Map.NPCs[u3.Active].HumanoidRootPart or GetActiveHouse();
        else
            v38 = GetActiveQuest();
        end;

        local v39 = v38 or Map.NPCs["Smug Zam"].HumanoidRootPart;

        if not v39 then
            Parent.Compass.Visible = false;

            return;
        end;

        Parent.Compass.CurrentCamera = Workspace.CurrentCamera;
        local v40 = Parent.Compass.CurrentCamera.CFrame * CFrame.new(0, -1, -4.25);
        Parent.Compass.Arrow.CFrame = CFrame.new(v40.Position, v39.Position) * CFrame.Angles(0, 1.5707963267948966, 0);
        local math_floor_ret = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - v39.Position).Magnitude);
        Parent.Compass.Distance.Text = math_floor_ret;
        Parent.Compass.Visible = true;
    end;

    RunService.RenderStepped:Connect(function() -- Line: 430
        -- upvalues: TrackTarget (copy)
        TrackTarget();
    end);
end;

task.spawn(function() -- Line: 435
    -- upvalues: ReplicatedStorage (copy), Begin (copy)
    if ReplicatedStorage.wkspc.gametype.Value == "TrickOrTreat" then
        Begin();
    end;

    ReplicatedStorage.wkspc.gametype:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 439
        -- upvalues: ReplicatedStorage (ref), Begin (ref)
        if ReplicatedStorage.wkspc.gametype.Value ~= "TrickOrTreat" then
            return;
        end;

        Begin();
    end);
end);
pcall(function() -- Line: 445
    game:GetService("StarterGui"):SetCore("AvatarContextMenuEnabled", false);
end);

return {};