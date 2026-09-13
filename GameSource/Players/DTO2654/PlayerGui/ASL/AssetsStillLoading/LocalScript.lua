-- Decompiled with Potassium's decompiler.

service = game:GetService("ContentProvider");
wait(5);

if service.RequestQueueSize > 2 then
    script.Parent.Parent.Enabled = true;
end;

while task.wait(0.33) do
    if service.RequestQueueSize <= 2 then
        script.Parent.Parent.Enabled = false;
        break;
    end;

    script.Parent.Text = "Assets still loading; (" .. service.RequestQueueSize .. ")";
end;

while true do
    while true do
        if not task.wait(1) then
            return;
        end;

        if service.RequestQueueSize > 2 then
            break;
        end;

        script.Parent.Parent.Enabled = false;
    end;

    script.Parent.Parent.Enabled = true;

    while task.wait(0.33) do
        script.Parent.Text = "Assets loading; (" .. service.RequestQueueSize .. ")";

        if service.RequestQueueSize <= 2 then
            script.Parent.Parent.Enabled = false;
            break;
        end;
    end;
end;