Build a new release form scratch or update old version
========

    Vagrantfile   the OS in config.vm.box
                  https://atlas.hashicorp.com/boxes/search?utf8=%E2%9C%93&sort=&provider=&q=ubuntu+15.04
    bootstrap.sh  for OS packages
    versions.txt  for Perl 5, Rakudo Perl 6, and Node.js
                  http://www.cpan.org/src/README.html
                  http://rakudo.org/
                  https://nodejs.org/en/
    install.pl    (the code of installing Perl 5, Perl 6, etc)
    modules.txt   for Perl 5 Modules


    Destroy exisiting box:  (vagrant destroy)
    Create a new box:       (vagrant up)

If we don't upgrade the OS or perl then I think we can start from the existing box.

We might need to run (vagrant provision) several times if some of the modules don't get installed on the first run.

We might need to manually copy the  bash_profile file
unless we can figure out why bootstrap.sh does not copy it.


TODO: Add a script that will test some of the modules.



Release a new box run
========


    vagrant halt

    vagrant package --output pde.box

Then upload to https://atlas.hashicorp.com/

Select the 'Vagrant' menu item at the top: https://atlas.hashicorp.com/vagrant
Select the box:  szabgab/pde
New version
  1.1.0       (or whatever version number we would like to give)
  perl 5.22.0 and a bunch of CPAN modules.
Create new provider
  virtualbox
  Upload   (radio)



For new Vagrant series
========

    Create a Vagrant box with the Web UI
      Name: szabgab/cm
      Short Desription: Code Maven Environment
      [Create Box]

