#!/bin/bash

# Prompt the user to enter their first name
read -p "Enter your first name: " firstName

# Define the folder path
myFolder="./submission_reminder_sandrine"

# Check if the folder exists
if [ -d "$myFolder" ]; then
    # Check if the variable firstName is 'sandrine'
    if [ "$firstName" == "sandrine" ]; then
        echo "The folder you are trying to create already exists. Exiting ....."
        exit 0
    else
        # Create a new folder and copy contents
        newFolder="submission_reminder_$firstName"
        mkdir -p "$newFolder" && cp -r "$myFolder/"* "$newFolder"
        echo "New folder successfully created and contents copied."
    fi
else
	mainDir="submission_reminder_$firstName"

	mkdir -p "$mainDir/app" "$mainDir/modules" "$mainDir/config" "$mainDir/assets"

	cp reminder.sh "$mainDir/app"
	cp functions.sh "$mainDir/modules"
	cp submissions.txt "$mainDir/assets"
	cp config.env "$mainDir/config"

	#Creating startup.sh
	cat << 'EOF' > "$mainDir/startup.sh"
	#!/bin/bash
	source ./config/config.env
	source ./modules/functions.sh
	bash app/reminder.sh
EOF

	chmod +x "$mainDir/startup.sh" ##making startup.sh executable

	#Adding five more students into the submissions.txt

	echo "Sandrine, Individual Summative, submitted" >> "$mainDir/assets/submissions.txt"
	echo "Elissa, Coding Lab, not submitted" >> "$mainDir/assets/submissions.txt"
	echo "Akinsanya, Shell Navigation, not submitted" >> "$mainDir/assets/submissions.txt"
	echo "Diana, Git, not submitted" >> "$mainDir/assets/submissions.txt"
	echo "Bienvenue, Passport to Canvas, submitted" >> "$mainDir/assets/submissions.txt"
fi
