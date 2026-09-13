-- Decompiled with Potassium's decompiler.

return {
    VM_INIT = function(p1, p2) -- Line: 3, Name: VM_INIT
        local v3 = p1:GetAttribute("Scale") or 1;
        local Part = Instance.new("Part");
        Part.Size = Vector3.new(0.05, 0.05, 0.05);
        Part.TopSurface = Enum.SurfaceType.Smooth;
        Part.BottomSurface = Enum.SurfaceType.Smooth;
        Part.Transparency = 1;
        Part.Shape = Enum.PartType.Ball;
        Part.CanCollide = false;
        Part.Parent = p1["Right Arm"];
        local Weld = Instance.new("Weld");
        Weld.Part0 = Part;
        Weld.Part1 = p1["Right Arm"];
        Weld.C0 = Weld.C0 * CFrame.new(0, 2.5 * v3, 0);
        Weld.Parent = p1;
        Weld.Name = "Bob";
        local CFrameValue = Instance.new("CFrameValue");
        CFrameValue.Value = Weld.C0;
        CFrameValue.Parent = Weld;
        CFrameValue.Name = "Origin";
    end
};