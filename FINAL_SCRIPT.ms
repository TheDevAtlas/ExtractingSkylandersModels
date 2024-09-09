-- Define the folders containing model and animation files
modelFolder = "C:\\Users\\jacob\\Documents\\GitHub\\SkylandersModels\\Assets\\Skylanders\\Actors\\"
animationFolder = "C:\\Users\\jacob\\Desktop\\animationMain\\"

-- Get all model files from the model folder
modelFiles = getFiles (modelFolder + "*.fbx")

-- Function to read animation names from a corresponding text file
fn getAnimationNamesFromFile animationFile =
(
    -- Construct the corresponding text file path
    local txtFilePath = getFileNamePath animationFile + getFileNameFile animationFile + ".txt"
	print animationFile
    local animNames = #()
    
    -- Check if the text file exists
    if doesFileExist txtFilePath do
    (
        -- Open the text file for reading
        local file = openFile txtFilePath
        while not eof file do
        (
            append animNames (readLine file)
        )
        close file
    )
    return animNames
)

testEscape = 0

-- Loop through each model file using its index
for i = 239 to modelFiles.count do --modelFiles.count
(
	testEscape += 1
    -- Get the current model file using the index
    modelFile = modelFiles[i]
    
    -- Determine the output directory for this model file
    modelName = getFilenameFile modelFile
    outputDirectory = "C:\\Users\\jacob\\Desktop\\animout\\" + modelName
    
    -- Create the output directory if it doesn't exist
    if not doesFileExist outputDirectory do makeDir outputDirectory

    -- Construct the path for the corresponding animation file and text file
    animationFile = animationFolder + modelName + ".hka"
    
    -- Get animation names from the corresponding text file
    animationNames = getAnimationNamesFromFile(animationFile)
	
	--print animationNames.count

    -- Loop through each animation name if the list is not empty
    if animationNames.count > 0 do
    (
		numberofAnimation = animationNames.count
		
		if numberofAnimation > 100 do
		(
			numberofAnimation = 100
		)
		
        for j = 1 to numberofAnimation do --animationNames.count
        (
            -- Clear the scene to reset for the next animation
            resetMaxFile #noPrompt

            -- Re-import the model for the next iteration
            importFile modelFile #noPrompt

            -- Convert loop index to a string
            indexString = (j-1) as string

            -- Function to launch PowerShell without showing the window
            shellLaunch "powershell" ("-windowstyle hidden -Command \"Add-Type -AssemblyName System.Windows.Forms; Start-Sleep -Milliseconds 500; [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(350, 330); Start-Sleep -Milliseconds 500; &'C:\Users\jacob\Desktop\singlepress.exe';Start-Sleep -Milliseconds 500; [System.Windows.Forms.SendKeys]::SendWait('%m'); Start-Sleep -Milliseconds 500; [System.Windows.Forms.SendKeys]::SendWait('" + indexString + "'); Start-Sleep -Milliseconds 500; [System.Windows.Forms.SendKeys]::SendWait('%i');\"")

            -- MaxScript code to bring 3ds Max back to the foreground
            fn BringMaxToFront =
            (
                local hwnd = (windows.getMAXHWND())
                if hwnd != undefined do
                (
                    windows.SendMessage hwnd 0x0112 0xF120 0 -- WM_SYSCOMMAND, SC_RESTORE
                )
            )

            -- Call the function to bring 3ds Max to the front
            BringMaxToFront()
            
            -- Import the Havok file
            importFile animationFile

            -- Define the output file path using the model and animation names
            outputFilePath = outputDirectory + "\\" + animationNames[j] + ".fbx"

            -- Export the animation as FBX
            exportFile outputFilePath #noPrompt selectedOnly:false
        )
    )
)
