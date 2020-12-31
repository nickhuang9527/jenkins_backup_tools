#!/bin/bash
# Backs up the /var/lib/jenkins directory and uploads the archive to artifactory
# refer to https://gist.github.com/btamayo/c74c18a51b0a75a1cff9923d914668b0

echo "pwd: $(pwd)"

TIMESTAMP="$(date +'%Y%m%d-%H%M%S')"
echo "JENKINSBACKUP: Starting Jenkins backup at $TIMESTAMP"
ARCHIVENAME=jenkins-config-$TIMESTAMP.tar.gz
BACKUPFOLDER=$HOME/docker/volumes/jenkins_android_volume
GDUPLOADFOLDERID=${Your google drive folder id}

tar -zcPf jenkins-config-$TIMESTAMP.tar.gz $BACKUPFOLDER
echo "JENKINSBACKUP: Wrote archive $ARCHIVENAME"

echo "JENKINSBACKUP: Uploading $ARCHIVENAME to Google Drive ($GDUPLOADFOLDERID)"
/usr/local/bin/gdrive --service-account sa.json upload -p $GDUPLOADFOLDERID $ARCHIVENAME

echo "JENKINSBACKUP: Deleting archive file $ARCHIVENAME"
rm -f $ARCHIVENAME

echo "JENKINSBACKUP: Backup complete!"
