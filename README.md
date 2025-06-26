# My Resume

### CD Pipeline Setup

Configure Cloudflare API keys [here](https://dash.cloudflare.com/profile/api-tokens).

![zone key guide](https://trentwil.es/a/Q45icXd1uA.png)

Copy the `.env.example` to `.env` and set up the environment variables. Review the environment variables, as they are defined at the top of the `sync.sh` script to ensure they are correct for your project. Set a cronjob to run at a given interval (every 5-10 minutes will suffice).