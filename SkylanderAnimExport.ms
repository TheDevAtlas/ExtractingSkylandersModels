-- Model file
modelFile = "C:\\Users\\jacob\\Documents\\GitHub\\SkylandersModels\\Assets\\Skylanders\\Actors\\TreeRexout.fbx"

-- Havok file
havokFilePath = "C:\\Users\\jacob\\Desktop\\Extract\\treerex\\Temporary\\BuildServer\\ps4\\Output\\anims\\Skylanders\\TreeRex.hka"

-- List of animation names in the desired order
animationNames = #(
    "drive_run", "jumppad_flyup_loopend", "knockaway_front", "land", "railslide_sliding", 
    "drive_modswap_pose01", "drive_modswap_pose03", "attack_shootr_partial", "knockaway_getupback", 
    "magicmoment_levelspawn", "takehit_groundfront", "attack_gun_charge_40_partial", 
    "emotion_timeout02_partial", "pushblock", "attack_gun_charge_shoot02", "emotion_happy_partial", 
    "railslide_land", "jumppad_start", "magicmoment_fail", "knockaway_back", "knockaway_getupfront", 
    "attack_machinegun_end", "takehit_shield", "emotion_traversal_partial", "takehit_groundleft", 
    "drive_modswap_pose02", "attack_shootl_partial", "jump", "falling", "drive_impact", 
    "takehit_groundright", "attack_wowpow_rocket_jump", "run_stop", "attack_gun_charge_shoot01", 
    "run", "attack_wowpow_rocket_ride", "takehit_groundback", "jumppad_launch_2p", 
    "emotion_surprise_partial", "emotion_sad_partial", "attack_gun_charge_30_partial", 
    "attack_gun_charge_shoot_yamato", "drive_idle", "attack_gun_charge_shoot04", "land_running", 
    "magicmoment_intro", "walk", "jumppad_launch", "attack_wowpow_megablast", "jumppad_flyup_loop", 
    "attack_wowpow_rocket", "emotion_angry_partial", "attack_machinegun_start", 
    "emotion_timeout01_partial", "jumppad_wait", "pvp_victory_loop", "railslide_takehit", 
    "magicmoment_failloop", "attack_machinegun_loop", "attack_gun_charge_shoot_yamato_roll", 
    "attack_gun_charge_shoot03", "attack_lob", "idle", "attack_gun_charge_shoot05", 
    "emotion_idle_partial"
)

-- Number of animations in the Havok file
numAnimations = 4 --animationNames.count

-- Output directory for FBX files
outputDirectory = "C:\\Users\\jacob\\Desktop\\Extract\\treerex\\Output"

-- Loop through each animation
for i = 1 to numAnimations do
(
    -- Clear the scene to reset for the next animation
    resetMaxFile #noPrompt

    -- Re-import the model for the next iteration
    importFile modelFile #noPrompt
	
	-- Convert loop index to a string
    indexString = i as string
	-- indexString = 37 as string

     -- Function to launch PowerShell without showing the window
	shellLaunch "powershell" ("-windowstyle hidden -Command \"Add-Type -AssemblyName System.Windows.Forms; Start-Sleep -Milliseconds 1300; [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(350, 330); Start-Sleep -Milliseconds 1300; &'C:\Users\jacob\Desktop\singlepress.exe';Start-Sleep -Milliseconds 1300; [System.Windows.Forms.SendKeys]::SendWait('%m'); Start-Sleep -Milliseconds 1300; [System.Windows.Forms.SendKeys]::SendWait('" + indexString + "'); Start-Sleep -Milliseconds 1300; [System.Windows.Forms.SendKeys]::SendWait('%i');\"")

	-- MaxScript code to bring 3ds Max back to the foreground
	fn BringMaxToFront =
	(
		local hwnd = (windows.getMAXHWND())
		if hwnd != undefined do
		(
			windows.SendMessage hwnd 0x0112 0xF120 0 -- WM_SYSCOMMAND, SC_RESTORE
			--windows.SetForegroundWindow hwnd
		)
	)

	-- Call the function to bring 3ds Max to the front
	BringMaxToFront()
	
    -- Import the Havok file
    importFile havokFilePath

    -- Define the output file path using the animation name
    outputFilePath = outputDirectory + "\\" + animationNames[i] + ".fbx"

    -- Export the animation as FBX
    exportFile outputFilePath #noPrompt selectedOnly:false
)
