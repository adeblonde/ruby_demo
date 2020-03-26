# Ruby demonstrator

This project aims at providing a template for starting and developing a Ruby on Rails application

## Technical requirements

To run this project, you will need a Unix shell. This project is compatible with MacOS, Ubuntu on Linux and Ubuntu through WSL on Windows.

## Quickstart

First, be sure that the bash script have the execution rights

```bash
chmod 755 *.sh
chmod 755 tools/*.sh
```

If you are running WSL, you may need some extra steps before being able to use Unix ACL :

```bash
sudo umount /mnt/c 
sudo mount -t drvfs C: /mnt/c -o metadata 
```

In order to install all the dependencies, create a demo app and launch a debug server for it, please run the following script, after having set the parameter 'APP_NAME' to your liking :

```bash
./prepare_workspace.sh
```

Once you have configured your workspace and you have a demo app, you can add you own legacy app into the project, by deleting the following folders and files in the '<your_app_name>' folder :

- app
- config
- db
- Gemfile

Then, you can copy and paste the following folders and files into the project from your legacy Ruby app :

- app
- config
- db
- Gemfile
- Capfile (if you have one)

Once you have done it, you can run the following script, after having checked the 'APP_NAME' parameter inside.

```bash
./reload_new_app.sh
```

## Development

To launch your dev server, after having checked the 'APP_NAME' parameter inside :

```bash
./launch_dev.sh
```

### Database management

In order to connect to your MySQL database :

```bash
mysql -h 127.0.0.1 -D ruby_demo_app_development -u ruby_demo_app -ppassword
```

Please replace '127.0.0.7' by whatever your MySQL database hostname is, 'ruby_demo_app' by the name of your app user (check for development or production environment), 'ruby_demo_app_development' by the name of the app database, and 'password' by the user.'s password (keep the 'p' letter without blank space before the password).

### Docker management



## TODO

Warning, production mode not ready yet.