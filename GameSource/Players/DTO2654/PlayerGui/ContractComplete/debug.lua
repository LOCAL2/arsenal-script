-- Decompiled with Potassium's decompiler.

local Linker = require(game.ReplicatedStorage.Modules.Linker);

while task.wait() do
    task.wait(6);
    Linker.Fire("HW23Message", "All Treasures Found", "You\'ve collected all the treasures!", 1000, 2);
end;