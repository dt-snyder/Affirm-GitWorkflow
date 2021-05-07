# Salesforce DX Project with Affirm CI/CD

Example repo that uses `sfdx-cli` and `sfdx-affirm` to validate and deploy features to specific instances of salesforce.

## Resources

Below are some helpful resources that you should already understand before getting much further into using something like what's shown here. Take some time to understand SFDX-CLI, GIT, and the commands that SFDX-Affirm has.

### SFDX-CLI Resources

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)

### SFDX-AFFIRM Resources

- [SFDX-AFFIRM](https://www.npmjs.com/package/sfdx-affirm)

## Setting up Git Workflow In Your Repo

If you're interested in using this flow for your development this section will help you get started.

### Creating Secrets

Most of the setup you'll need to do is in this section. In order for the workflows to do their thing and validate/deploy to your Salesforce instances it needs to have access to your instances. The number of instances and workflows you create for your team will tell you how many times you need to repeat these steps. This section details all the steps you need to complete to get authenticated.

#### Overview

1. Create self-signed Cert for use in Salesforce Connected app
2. Create a Connected App In Salesforce
3. Create Secrets in GitHub
4. Configure your workflow

### Create a self-signed cert & encrypt it

The first step is to make your Private Key and Self-Signed Digital Certificate. This guide from the (Salesforce DX Developer Guide will get you where you need to be.)[https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_auth_key_and_cert.htm] 

The goal here is to have a private `server.key` file and to enter the value returned in step five of the guide into the `Digital Certificate` field of your connected app. Save the `Digital Certificate` somewhere for use in the Create Connected App section.

We now need to encrypt our `server.key` file so it can be safely committed to the repo. I used (this guide from GitHub)[https://docs.github.com/en/actions/reference/encrypted-secrets#using-encrypted-secrets-in-a-workflow] to get this done and the `decrypt_secret.sh` is directly from there. Like they say, remember the pass phrase you use as we will need it in the last section of this guide.

### Create Connected App

Log into your salesforce instance and create a connected app. This guide, (Authorize an Org Using the JWT Bearer Flow)[https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_auth_jwt_flow.htm], is a good place to start but doesn't really cover all the details of creating the connected app; to save you some time my recommended settings are below (if it's not listed it's not important).

- API Name: give it a name (idc)
- Enable for Device Flow: true (used the callback url they drop in there for you)
- Require Secret for Refresh Token Flow: true
- Require Secret for Web Server Flow: true
- Digital Certificate: enter the value that was returned in step 5 of the previous sections guide.

Once you have created your connected app navigate to the manage page and update the `Permitted Users` field to `Admin approved users are pre-authorized`. This will ensure that only specific users in your instance can auth this way.

Scroll down the page a bit and add the system admin profile to the profiles section. That will ensure you (assuming you're an admin) can use the connected app. In production you should probably create a user just for this and I would also recommend a permission set that you can then add to the connected app instead of a profile but that's really all up to you.

### Create GitHub Secrets

You will need to create at least 4 Repository secrets but the total number of these you create will be dependent on the number of instances you want to validate/deploy against. To get started we will create the following for Repository secrets.

- `SFDX_CLIENT_ID`: This is the `Consumer Key` from your Salesforce Connected App
- `SFDX_UN`: This is the username of the user you want to run your validation/deployment as in Salesforce (must be granted access to the Connected App)
- `SFDX_URL`: `https://login.salesforce.com/` OR `https://test.salesforce.com/` OR a custom domain if you're into that
- `SFDX_JWT_PASS`: the passphrase that you used to encrypt your `server.key`
