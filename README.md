# bigdatainfra
Maintain deploy script for bigdatainfra plateform

This project is based on following prevoise works:
- create git repository to maintain components code.
- components jar and images are deployed to nexus via jenkins

How-to-use:
1. Add cluster deploy nodes in conf/*.list file.
2. ./1_deploy_master_envSetup.sh
3.  update all configuration files in ~/bigdatainfra_deploy/package/
4. ./2_deploy_master_confUpdate.sh
5. ./3_deploy_slave.sh
6. Go througn steps in beforestart/${component_name} file
7. start services and going on play 
