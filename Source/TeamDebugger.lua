-- ==========================================
-- Team Debugger Log Script
-- ==========================================
local TeamsService = game:GetService("Teams")
local Players = game:GetService("Players")

print("----------------------------------------")
print("--- [ TEAM DEBUGGER REPORT ] ---")
print("----------------------------------------")

local teams = TeamsService:GetTeams()
if #teams == 0 then
    warn("[!] ไม่พบ Teams ใน Teams Service (เกมนี้อาจจะไม่ได้ใช้ Teams Service หรือตั้งค่าเป็น Free For All)")
else
    print("[+] พบทั้งหมด " .. tostring(#teams) .. " ทีม:")
    for i, team in ipairs(teams) do
        print(string.format("  [%d] Team Name: '%s' | TeamColor: %s", i, team.Name, tostring(team.TeamColor)))
    end
end

print("\n[+] รายชื่อผู้เล่นและทีมปัจจุบัน:")
for _, player in ipairs(Players:GetPlayers()) do
    local teamName = player.Team and player.Team.Name or "No Team (Nil)"
    local teamColor = player.TeamColor and tostring(player.TeamColor) or "N/A"
    print(string.format("  - Player: %s (%s) | Team: %s | Color: %s", player.Name, player.DisplayName, teamName, teamColor))
end
print("----------------------------------------\n")
