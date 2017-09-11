# Deploy DVWA with vagrant
### Before you start read <a href="https://github.com/ethicalhack3r/DVWA#warning" target="_blank">THIS</a>. But please come back :)
---
Now clone the repository and jump to cloned directory:
```
https://github.com/99stealth/DVWA-vagrant.git
cd DVWA-vagrant
```
---
Before we start you need to set password for MySQL DB andyour reCAPTCHA public and private keys. Open file *credentials.conf* and set needed data right after =
> You can register your reCAPTCHA keys <a href="https://www.google.com/recaptcha" target="_blank">HERE</a>
---
Now we are ready to launch vagrant:
```
vagrant up
```
---
Ater process is finished you can start working with DVWA. Open your web browser and enter the address of virtual machine. By default it is http://192.168.32.110/dvwa

Congratulations! Now try to hack it ;)
