-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = game:GetService("RunService"):IsStudio() and 3436218611 or game.Players.LocalPlayer.UserId;
local u3 = game.Players:CreateHumanoidModelFromUserId(u2);
local MarketplaceService = game:GetService("MarketplaceService");
local u4 = {};

function v1.Setup() -- Line: 9
    -- upvalues: u3 (ref), u2 (copy), MarketplaceService (copy), u4 (copy)
    if u3 == nil then
        u3 = game.Players:CreateHumanoidModelFromUserId(u2);

        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("Script") or (descendant:IsA("LocalScript") or descendant:IsA("ModuleScript")) then
                descendant:Destroy();
            end;
        end;

        if u3.Humanoid:FindFirstChild("Animator") == nil then
            Instance.new("Animator").Parent = u3.Humanoid;
        end;
    end;

    for _, child in script.Parent:GetChildren() do
        if child:IsA("ImageButton") then
            if child:GetAttribute("ProductID") then
                if child:GetAttribute("ProductID") ~= 0 and child:GetAttribute("AnimID") then
                    child.Visible = true;

                    if child:GetAttribute("AnimID") == 0 then
                        local success, result = pcall(function() -- Line: 35
                            -- upvalues: child (copy)
                            child:SetAttribute("AnimID", game.InsertService:LoadAsset(child:GetAttribute("ProductID")):GetChildren()[1].AnimationId);
                        end);
                        warn(success, result);

                        if not success then
                            child.Visible = false;
                        end;
                    end;
                end;
            else
                child.Visible = false;
            end;
        end;
    end;

    for _, child in script.Parent:GetChildren() do
        if child:IsA("ImageButton") and child.Visible then
            local Attribute = child:GetAttribute("ProductID");

            if Attribute ~= 0 then
                local u5 = nil;
                local success, result = pcall(function() -- Line: 64
                    -- upvalues: u5 (ref), MarketplaceService (ref), Attribute (copy)
                    u5 = MarketplaceService:GetProductInfo(Attribute, Enum.InfoType.Asset);
                end);

                if u5 then
                    local Name = u5.Name;
                    local PriceInRobux = u5.PriceInRobux;
                    local Creator = u5.Creator;
                    local Name2 = Creator.Name;

                    if Creator.CreatorTargetId == 2820112 then
                        Name2 = "by " .. game:GetService("GroupService"):GetGroupInfoAsync(35169216).Name;
                    end;

                    if child:FindFirstChild("TPCredit") then
                        child.TPCredit.Text = Name2;
                    end;

                    child.Price.Text = "" .. PriceInRobux;

                    if string.match(Name, "Arsenal:") then
                        Name = string.gsub(Name, "Arsenal: ", "");
                    end;

                    child.ItemLabel.Text = Name;
                    local Attribute2 = child:GetAttribute("AnimID");

                    if Attribute2 then
                        local v6 = CFrame.new(0, 0, -8) * CFrame.Angles(0, 3.141592653589793, 0);
                        local WorldModel = Instance.new("WorldModel");
                        local v7 = u3:Clone();
                        v7.Parent = WorldModel;
                        v7:PivotTo(v6);
                        WorldModel.Parent = child.Item.ViewportFrame;
                        local Animation = Instance.new("Animation");
                        Animation.AnimationId = "rbxassetid://" .. Attribute2;
                        local u8 = v7.Humanoid.Animator:LoadAnimation(Animation);

                        if u8 then
                            u8:Play();

                            if child:GetAttribute("LoopMe") then
                                task.spawn(function() -- Line: 146
                                    -- upvalues: u8 (copy)
                                    while task.wait(u8.Length) and u8 do
                                        u8:Play();
                                    end;
                                end);
                            end;
                        end;
                    else
                        child.Visible = false;
                    end;
                else
                    warn("INVALID UGC EMOTE PRODUCT " .. Attribute);
                    warn(success, result);
                    child.Visible = false;
                end;
            end;
        end;
    end;

    for _, child in script.Parent:GetChildren() do
        if child:IsA("ImageButton") and child.Visible then
            local v9 = child.MouseButton1Click:Connect(function() -- Line: 164
                -- upvalues: MarketplaceService (ref), child (copy)
                MarketplaceService:PromptPurchase(game.Players.LocalPlayer, child:GetAttribute("ProductID"));
            end);
            table.insert(u4, v9);
        end;
    end;
end;

function v1.Cleanup() -- Line: 173
    -- upvalues: u4 (copy)
    for _, v in u4 do
        v:Disconnect();
    end;

    table.clear(u4);

    for _, child in script.Parent:GetChildren() do
        if child:FindFirstChild("Item") then
            for _, child2 in child.Item.ViewportFrame:GetChildren() do
                child2:Destroy();
            end;
        end;
    end;
end;

return v1;