# SFDX  App

## Dev, Build and Test

1. import demo Idea Zone
sfdx force:data:tree:import --targetusername IdeaProject --plan sfdx-out/export-demo-Community-Property__c-plan.json
Manually: Create new idea zone "Tracker Ideas" (CLASSIC MODE)

2. push code
sfdx force:source:push -f

3. assign permission set
sfdx force:user:permset:assign -n "Idea_Tracker"

## Resources


## Description of Files and Directories


## Issues


