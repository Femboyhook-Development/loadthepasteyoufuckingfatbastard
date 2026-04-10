
local win = ambani.MenuTabbedWindow("Femboyhook | Internal", 90, 90, 440, 540, 120);
ambani.MenuSetAccent(win, 60, 140, 255);
ambani.MenuSetKeybind(win, 116);
local tabInfo = ambani.MenuAddTab(win, "Dashboard");
local grpPlayer = ambani.MenuGroup(tabInfo, "Player", 12, 12, 200, 230);
ambani.MenuText(grpPlayer, "User Session");
ambani.MenuText(grpPlayer, auth);
ambani.MenuText(grpPlayer, "");
local txtHealth = ambani.MenuText(grpPlayer, "Health: -- / --");
local txtPlayers = ambani.MenuText(grpPlayer, "Players: --");
ambani.MenuText(grpPlayer, "");
ambani.MenuText(grpPlayer, "Status: Online");
local grpSystem = ambani.MenuGroup(tabInfo, "System", 218, 12, 200, 230);
local txtPos = ambani.MenuText(grpSystem, "Position: --");
local txtScreen = ambani.MenuText(grpSystem, "Resolution: --");
ambani.MenuText(grpSystem, "");
ambani.MenuText(grpSystem, "Build: Release");
ambani.MenuText(grpSystem, "Mode: Internal");
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(400);
		ambani.MenuSetText(txtHealth, ("Health: %d / %d"):format(math.floor(ambani.GetHealth()), math.floor(ambani.GetMaxHealth())));
		local x, y, z = ambani.GetPos();
		ambani.MenuSetText(txtPos, ("Position: %.2f | %.2f | %.2f"):format(x, y, z));
		ambani.MenuSetText(txtPlayers, ("Players Online: %d"):format(ambani.GetPlayerCount()));
		local sw, sh = ambani.GetResolution();
		ambani.MenuSetText(txtScreen, ("Screen: %dx%d"):format(sw, sh));
	end;
end);
local tabAct = ambani.MenuAddTab(win, "Utilities");
local grpTools = ambani.MenuGroup(tabAct, "Tools", 12, 12, 400, 120);
ambani.MenuText(grpTools, "Quick Actions");
ambani.MenuButton(grpTools, "Copy Position", function()
	local x, y, z = ambani.GetPos();
	ambani.CopyToClipboard(("%.2f, %.2f, %.2f"):format(x, y, z));
	ambani.Notify("System", "Position copied");
end);
ambani.MenuButton(grpTools, "Open Browser", function()
	ambani.OpenUrl("https://google.com");
end);
local tabPlayer = ambani.MenuAddTab(win, "Player");
local grpPlayerTab = ambani.MenuGroup(tabPlayer, "Player Toggles", 12, 12, 400, 160);
ambani.MenuCheckbox(grpPlayerTab, "Block Aim", function()
	SetBlockAim(true);
	ambani.Notify("Block Aim", "Enabled");
end, function()
	SetBlockAim(false);
	ambani.Notify("Block Aim", "Disabled");
end);
local shootAllPeds = false;
ambani.MenuCheckbox(grpPlayerTab, "Shoot All Peds", function()
	ambani.Notify("Shoot All Peds", "Enabled");
	if shootAllPeds then
		ambani.Notify("Shoot All Peds", "Already running");
		return;
	end;
	shootAllPeds = true;
	Citizen.CreateThread(function()
		while shootAllPeds do
			Citizen.Wait(100);
			local playerPed = PlayerPedId();
			for _, ped in ipairs(GetGamePool("CPed")) do
				if ped ~= playerPed and (not IsPedAPlayer(ped)) and (not IsEntityDead(ped)) then
					local playerCoords = GetEntityCoords(playerPed);
					local targetCoords = GetEntityCoords(ped);
					ShootSingleBulletBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, targetCoords.x, targetCoords.y, targetCoords.z, 100, true, GetHashKey("WEAPON_PISTOL"), playerPed, true, false, 500);
				end;
			end;
		end;
		print("[Thread] ShootAllPeds thread stopped");
	end);
	ambani.Notify("Shoot All Peds", "Enabled");
end, function()
	ambani.Notify("Shoot All Peds", "Disabled");
	shootAllPeds = false;
end);
local tabMove = ambani.MenuAddTab(win, "Movement");
local grpMove = ambani.MenuGroup(tabMove, "Movement Options", 12, 12, 400, 120);
ambani.MenuCheckbox(grpMove, "WASD Strafe", function()
	ambani.Notify("WASD Strafe", "Enabled");
	WASD(true);
end, function()
	WASD(false);
	ambani.Notify("WASD Strafe", "Disabled");
end);
local tabMisc = ambani.MenuAddTab(win, "Misc");
local grpMisc = ambani.MenuGroup(tabMisc, "Miscellaneous", 12, 12, 400, 120);
ambani.MenuCheckbox(grpMisc, "Leftpeek", function()
	holding = true;
	ambani.Notify("Leftpeek", "[TOGGLED ON] Hold G to use Leftpeek");
end, function()
	holding = false;
	ambani.Notify("Leftpeek", "[TOGGLED OFF]");
	disableCamera();
end);
local asciilol = "\n[Ambani] $$$$$$$$\\ $$$$$$$$\\ $$\\      $$\\ $$$$$$$\\   $$$$$$\\ $$\\     $$\\ $$\\   $$\\  $$$$$$\\   $$$$$$\\  $$\\   $$\\ \n[Ambani] $$  _____|$$  _____|$$$\\    $$$ |$$  __$$\\ $$  __$$\\\\$$\\   $$  |$$ |  $$ |$$  __$$\\ $$  __$$\\ $$ | $$  |\n[Ambani] $$ |      $$ |      $$$$\\  $$$$ |$$ |  $$ |$$ /  $$ |\\$$\\ $$  / $$ |  $$ |$$ /  $$ |$$ /  $$ |$$ |$$  / \n[Ambani] $$$$$\\    $$$$$\\    $$\\$$\\$$ $$ |$$$$$$$\\ |$$ |  $$ | \\$$$$  /  $$$$$$$$ |$$ |  $$ |$$ |  $$ |$$$$$  /  \n[Ambani] $$  __|   $$  __|   $$ \\$$$  $$ |$$  __$$\\ $$ |  $$ |  \\$$  /   $$  __$$ |$$ |  $$ |$$ |  $$ |$$  $$<   \n[Ambani] $$ |      $$ |      $$ |\\$  /$$ |$$ |  $$ |$$ |  $$ |   $$ |    $$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |\\$$\\  \n[Ambani] $$ |      $$$$$$$$\\ $$ | \\_/ $$ |$$$$$$$  | $$$$$$  |   $$ |    $$ |  $$ | $$$$$$  | $$$$$$  |$$ | \\$$\\ \n[Ambani] \\__|      \\________|\\__|     \\__|\\_______/  \\______/    \\__|    \\__|  \\__| \\______/  \\______/ \\__|  \\__|\n                                                                                                                                                                                                       \n";
ambani.Notify("Script", "Script loaded successfully");
print(asciilol);
camHandle, camActive = 0, false;
holding = false;
G_KEY = 71;
local function disableCamera()
	if camActive then
		RenderScriptCams(false, true, 200, false, false);
		SetTimeout(400, function()
			if camHandle and camHandle ~= 0 then
				SetCamActive(camHandle, false);
				DestroyCam(camHandle, false);
				camHandle = 0;
			end;
		end);
		camActive = false;
	end;
end;
function updateCameraPosition()
	local ped = PlayerPedId();
	local cameraCoords = GetGameplayCamCoord();
	local cameraRotation = GetGameplayCamRot(2);
	local gameplayCamFov = GetGameplayCamFov();
	local coordsRelativeToPlayer = GetOffsetFromEntityGivenWorldCoords(ped, cameraCoords.x, cameraCoords.y, cameraCoords.z);
	if camHandle and DoesCamExist(camHandle) then
		AttachCamToEntity(camHandle, ped, coordsRelativeToPlayer.x - 1, coordsRelativeToPlayer.y, coordsRelativeToPlayer.z, true);
		SetCamCoord(camHandle, coordsRelativeToPlayer.x, coordsRelativeToPlayer.y, coordsRelativeToPlayer.z);
		SetCamRot(camHandle, cameraRotation.x, cameraRotation.y, cameraRotation.z, 2);
		SetCamFov(camHandle, gameplayCamFov);
	end;
end;
function enableCamera()
	if not camHandle or camHandle == 0 then
		camHandle = CreateCam("DEFAULT_SCRIPTED_CAMERA", true);
		if not DoesCamExist(camHandle) then
			disableCamera();
			return;
		end;
	end;
	SetCamActive(camHandle, true);
	SetCamAffectsAiming(camHandle, true);
	RenderScriptCams(true, true, 200, false, false);
	camActive = true;
	updateCameraPosition();
end;
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0);
		if holding and IsControlPressed(0, 58) then
			if not camActive then
				enableCamera();
			else
				updateCameraPosition();
				ShowHudComponentThisFrame(14);
			end;
		elseif camActive then
			disableCamera();
		end;
	end;
end);
cloudradar = false;
ambani.MenuCheckbox(grpMisc, "Cloudradar", function()
	cloudradar = true;
	ambani.Notify("Cloudradar", "[TOGGLED ON]");
end, function()
	cloudradar = false;
	ambani.Notify("Cloudradar", "[TOGGLED OFF]");
	nocloudradar();
end);
