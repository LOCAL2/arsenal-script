-- Decompiled with Potassium's decompiler.

return {
    { "TitleCard", {
            UpdateTitle = "RELOADED, STAGE 1",
            Date = "June 8th, 2025"
        } },
    { "Div" },
    { "Description", {
            Text = "Third time\'s the charm, right?\n\nI\'ve done a whole lot of stuff since the last update, and I\'m sorry about the radio silence! I hope this is what you guys have been looking for.\n\nAs always, thanks for playing Arsenal. More than ever, please reach out and let me know your thoughts on this as I add and change things.\n\n~ xonae 💤"
        } },
    { "Div" },
    { "Div2" },
    { "OneLine", {
            Text = "Client Code Restructuring"
        } },
    { "Note", {
            Text = "~22,500 lines of client code have been restructured for easier development."
        } },
    { "Note", {
            Text = "Development speed and capabilities are vastly improved, so expect to see a lot more stuff from us!"
        } },
    { "Note", {
            Text = "This has also resulted in some performance improvements!"
        } },
    { "Div" },
    { "Div" },
    { "OneLine", {
            Text = "Particle and Trail Improvements"
        } },
    { "Note", {
            Text = "Commonly referred to as \"visuals\", these have been optimised a ton!"
        } },
    { "Note", {
            Text = "If you still experience issues, there are now more in-depth settings for disabling/adjusting these."
        } },
    { "Note", {
            Text = "Disabling them entirely will also now save network bandwidth, hopefully reducing network spikes!"
        } },
    { "Div" },
    { "Div" },
    { "OneLine", {
            Text = "Hit Registration Improvements"
        } },
    { "Note", {
            Text = "Hit registration should now be much more accurate, with more leniency in most cases."
        } },
    { "Note", {
            Text = "More informational \"hit debug\" messages have been added for diagnosing any further issues."
        } },
    { "Note", {
            Text = "If you believe a shot should\'ve hit, check the bottom left of your screen for those red messages!"
        } },
    { "Div" },
    { "Div" },
    { "OneLine", {
            Text = "Networking Overhaul"
        } },
    { "Note", {
            Text = "All game events have been ported to a brand new networking system under the hood!"
        } },
    { "Note", {
            Text = "This results in less overall bandwidth being used, while also cutting down on ping spikes from packet loss."
        } },
    { "Note", {
            Text = "Many game events have been optimised to use even less bandwidth in addition to this. Huge win for slower connections!"
        } },
    { "Div" },
    { "Div" },
    { "OneLine", {
            Text = "Miscellaneous:"
        } },
    { "Note", {
            Text = "- Added viewmodel sway based on camera movement. Can be disabled in settings!"
        } },
    { "Note", {
            Text = "- Re-added fix for viewmodels clipping through close geometry."
        } },
    { "Note", {
            Text = "- Weapon walkspeed reductions are halved, and equipping weapons is 15% faster."
        } },
    { "Note", {
            Text = "- Recoil and weapon spread have been halved."
        } },
    { "Note", {
            Text = "- Weapon walkspeed reductions are halved, and equipping weapons is 15% faster."
        } },
    { "Note", {
            Text = "- Server geolocation is now much more accurate."
        } },
    { "Note", {
            Text = "- A huge amount of bugs have been fixed."
        } }
};