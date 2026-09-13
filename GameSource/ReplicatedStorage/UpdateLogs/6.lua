-- Decompiled with Potassium's decompiler.

return {
    { "TitleCard", {
            UpdateTitle = "Minor Patch",
            Date = "April 21st, 2023"
        } },
    { "Div" },
    { "Description", {
            Text = "We hope you\'re all enjoying the recent content updates!\n\nWe\'ve been hard at work behind the scenes working on some interesting stuff... but for now, we thought we\'d adjust some things based on community feedback we\'ve received.\n\nTake a look below and let us know what you think about these changes on our socials. Thanks for playing!"
        } },
    { "Div2" },
    { "Div" },
    { "OneLine", {
            Text = "Removed 2 maps from public rotation:"
        } },
    {
        "ImagesWithText",
        {
            Items = {
                { game.ReplicatedStorage.ItemData.Images.MapVote.Tropical.Value, "Tropical" },
                { game.ReplicatedStorage.ItemData.Images.MapVote.Township.Value, "Township" }
            }
        }
    },
    { "Div" },
    { "OneLine", {
            Text = "Removed 1 gamemode from public rotation:"
        } },
    {
        "ImagesWithText",
        {
            Items = {
                { game.ReplicatedStorage.ItemData.Images.MapVote["Shotguns Only"].Value, "Shotguns Only" }
            }
        }
    },
    { "Div" },
    { "OneLine", {
            Text = "Extra patch notes:"
        } },
    { "Note", {
            Text = "- Adjusted internal systems for performance benefits"
        } },
    { "Div" }
};