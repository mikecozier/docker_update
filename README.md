# Docker Update Automation Script

This script automates the process of keeping your Docker containers up-to-date by:

* Checking for the latest image versions.
* Pulling updates if a newer version is found.
* Restarting containers with the updated images.
* Sending email notifications upon successful updates.
* Logging all activities for audit and troubleshooting.

## 🚀 Features

* **Automated Updates:** Checks and updates all running Docker containers.
* **Email Notifications:** Get notified when a container is updated.
* **Logging:** Maintains a log file for each update run.
* **Manual Trigger:** Run the script anytime using the `docker_update` alias.
* **Scheduled Execution:** Automatically runs daily at 5 am via cron.

## 📂 Installation

1. Clone the repository:

   git clone https://github.com/mikecozier/docker-update-script.git
   cd docker-update-script

2. Set up email configuration:

   * Update the `TO_EMAIL` and path to your `.muttrc` file in the script.

3. Make the script executable:

   chmod +x docker_update.sh

4. Add a cron job to run the script daily at 5 am:

   crontab -e

   Add the following line:

   0 5 * * * /path/to/docker_update.sh
   
6. Create an alias for manual execution:

   alias docker_update='/path/to/docker_update.sh'

## 📝 Usage

Run manually: docker_update

Check the update log: cat /var/log/docker_update.log

## 💌 Email Notifications

The script uses `mutt` for email alerts. Make sure your system is configured with `mutt` and your email settings are properly set in the script.

## 📋 Example Output

```
Starting Docker update check at Mon May 10 05:00:01 EDT 2025  
Checking for updates for container: pihole  
Current image: pihole/pihole:latest  
Pulling the latest image for pihole/pihole:latest  
No update available for pihole  
Docker update check completed at Mon May 10 05:00:15 EDT 2025  
```

## 🌟 Contributing

Feel free to fork, submit issues, or create pull requests to improve the script!
