# bigdatainfra
Maintain deploy script for bigdatainfra plateform

This project is based on following prevoise works:
- create git repository to maintain components code.
- components jar and images are deployed to nexus via jenkins

How-to-use:
1. Add cluster slaves nodes in ip.list file.
2. Run deploy_master.sh at master node.
3. Run deploy_slave.sh at master node for slave nodes environment set-up.
