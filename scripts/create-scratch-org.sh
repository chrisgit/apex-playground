# Create a scratch org and make it the default scratch org
sfdx force:org:create --setalias="apex-playground" --durationdays=7 --definitionfile=./config/project-scratch-def.json --nonamespace --setdefaultusername
# If you do not want this scratch org to be the default username
# https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_cli_usernames_orgs.htm
# sfdx force:config:set defaultusername=me@my.org 