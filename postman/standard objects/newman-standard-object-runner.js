const { spawn } = require('child_process');

async function execute(command, commandParameters, options = { stdio: 'inherit', shell: true }) {
    let output = "";
    return new Promise((resolve, reject) => {
        let cp = spawn(command, commandParameters, options);
        if (cp.stdout) {
            cp.stdout.on('data', (data) => {
                output += data;
            });
        }
        cp.on('close', (code) => {
            code == 0 ? resolve(output) : reject(`${commandParameters[0]} failed with exit code:- ${code}`);
        });
    });
};

async function getUserInfo(user) {
    let commandResult = await execute('sfdx', ['force:org:display', `--targetusername=${user}`, '--json'], { shell: true });
    return JSON.parse(commandResult);
}

const main = async () => {
    try {
        let salesforceUserInfo = await getUserInfo('apex-playground');
        let collection = '"Standard Objects.postman_collection.json"';
        let tokenEnv = `accesstoken=${salesforceUserInfo.result.accessToken}`;
        let urlEnv = `orgurl=${salesforceUserInfo.result.instanceUrl}`;
        // ^^^ Have a variable to indicate that we are running from Newman commandline rather than Post or 
        // check for Global/Environment variables in your scripts (like below)
        // let environmentOrg = pm.environment.get('orgurl');
        // let collectionOrg = pm.collectionVariables.get('orgurl');
                // Use the one with higher precedence, newman only being able to set environment variables
        // See: https://learning.postman.com/docs/sending-requests/variables/


        await execute('newman', ['run', collection, '--env-var', tokenEnv, '--env-var', urlEnv]);
    } catch (error) {
        console.log(`Oh dear, somethings gone wrong ${error}`);
    }
}

main();
