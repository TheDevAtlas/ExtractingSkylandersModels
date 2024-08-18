-- Path to model file
modelFile = "C:\\Users\\jacob\\Documents\\GitHub\\SkylandersModels\\Assets\\Skylanders\\Spyro\\spyro.fbx"

-- Define the path to your Havok file
havokFilePath = "C:\\Users\\jacob\\Desktop\\Skylanders\\SkylandersExtracting\\Spyro\\spyro\\Temporary\\BuildServer\\ps4\\Output\\anims\\Skylanders\\Spyro.hka"

-- Define the output directory for the FBX files
outputDirectory = "C:\\Users\\jacob\\Desktop\\Skylanders\\Anims"

-- List of animation names in the desired order
animationNames = #(
    "drive_run",
    "jumppad_flyup_loopend",
    "knockaway_front",
    "land",
    "railslide_sliding",
    "drive_modswap_pose01",
    "drive_modswap_pose03",
    "attack_shootr_partial",
    "knockaway_getupback",
    "magicmoment_levelspawn",
    "takehit_groundfront",
    "attack_gun_charge_40_partial",
    "emotion_timeout02_partial",
    "pushblock",
    "attack_gun_charge_shoot02",
    "emotion_happy_partial",
    "railslide_land",
    "jumppad_start",
    "magicmoment_fail",
    "knockaway_back",
    "knockaway_getupfront",
    "attack_machinegun_end",
    "takehit_shield",
    "emotion_traversal_partial",
    "takehit_groundleft",
    "drive_modswap_pose02",
    "attack_shootl_partial",
    "jump",
    "falling",
    "drive_impact",
    "takehit_groundright",
    "attack_wowpow_rocket_jump",
    "run_stop",
    "attack_gun_charge_shoot01",
    "run",
    "attack_wowpow_rocket_ride",
    "takehit_groundback",
    "jumppad_launch_2p",
    "emotion_surprise_partial",
    "emotion_sad_partial",
    "attack_gun_charge_30_partial",
    "attack_gun_charge_shoot_yamato",
    "drive_idle",
    "attack_gun_charge_shoot04",
    "land_running",
    "magicmoment_intro",
    "walk",
    "jumppad_launch",
    "attack_wowpow_megablast",
    "jumppad_flyup_loop",
    "attack_wowpow_rocket",
    "emotion_angry_partial",
    "attack_machinegun_start",
    "emotion_timeout01_partial",
    "jumppad_wait",
    "pvp_victory_loop",
    "railslide_takehit",
    "magicmoment_failloop",
    "attack_machinegun_loop",
    "attack_gun_charge_shoot_yamato_roll",
    "attack_gun_charge_shoot03",
    "attack_lob",
    "idle",
    "attack_gun_charge_shoot05",
    "emotion_idle_partial"
)

--print importerPlugin.classes

-- Number of animations in the Havok file
numAnimations = animationNames.count

-- Import the model file
-- importFile modelFile #noPrompt

-- Loop through each animation
for i = 0 to numAnimations-1 do
(
	-- Clear the scene to reset for the next animation
    resetMaxFile #noPrompt

    -- Re-import the model for the next iteration
    importFile modelFile #noPrompt
	
    -- Import Havok file with specific settings for the current animation
    importFile havokFilePath using:HavokImport motionId:i
	
	-- Delete everything that is not the animation name in the list

    -- Define the output file path using the animation name
    outputFilePath = outputDirectory + "\\" + animationNames[i+1] + ".fbx"

    -- Export the animation as FBX
    exportFile outputFilePath #noPrompt
)

-- Script complete
messageBox "Animation export complete!"
