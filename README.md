# jl_installer
Bash script that installs core applications and sets up base configuration for a new CentOS system

[![Watch the Demo Video](https://imgur.com/a/E68pVYv)](https://youtu.be/0z0whmJj-_0)

<a href="http://www.youtube.com/watch?feature=player_embedded&v=0z0whmJj-_0
" target="_blank"><img src="http://img.youtube.com/vi/0z0whmJj-_0/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>


#### 1. Notes

- I created this script to automatically setup all the core features I use when creating a new CentOS VM for testing.
- To be extra-safe the script will give you the option to double-check any changes you make to configuration files.

#### 2. Installation

- Pull down this script onto your CentOS machine
- Change the write permissions for the script:
```bash
chmod +x jl_installer.sh
```
- Run the script with sudo:
```bash
sudo ./jl_installer.sh
```
#### 3. Planned Updates

I'm planning to update the script in the future and I have some ideas about what new features I'd like to add. 

Here are those changes:
- Prompt user for additional "Useful Packages"
- Add installation and configuration section for SNMP
- Add more configuration options for SSH
- Allow user to quickly configure firewall rules? (maybe)
- Add ability for the script to work with Ubuntu
