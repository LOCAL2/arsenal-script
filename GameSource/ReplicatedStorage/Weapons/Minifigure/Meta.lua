-- Decompiled with Potassium's decompiler.

local v1 = {};
local wkspc = game:GetService("ReplicatedStorage"):WaitForChild("wkspc");

function v1.VM_INIT(p2, p3) -- Line: 5
    -- upvalues: wkspc (copy)
    if wkspc.gametype.Value == "Laser Tag" then
        local Toy = p2:FindFirstChild("Toy");

        if Toy then
            for _, descendant in Toy:GetDescendants() do
                if descendant:IsA("BasePart") and (descendant.Name ~= "Gun" and descendant.Name ~= "Mag") or descendant:IsA("Decal") then
                    descendant.Transparency = 1;
                end;
            end;
        end;
    else
        local Astro = p2:FindFirstChild("Astro");

        if Astro then
            Astro:Destroy();
        end;
    end;

    p2.Toy.TeamColor.Color = p3;
    p2.Toy.LeftHand.Color = p3;
    p2.Toy.RightHand.Color = p3;
    p2.Toy.LeftLowerLeg.Color = p3;
    p2.Toy.LeftUpperLeg.Color = p3;
    p2.Toy.RightLowerLeg.Color = p3;
    p2.Toy.RightUpperLeg.Color = p3;
    p2.Toy.UpperTorso.Color = p3;
    p2.Toy.LowerTorso.Color = p3;
end;

return v1;