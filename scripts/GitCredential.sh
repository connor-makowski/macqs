#!/bin/bash
echo "Running Git Credential Setup."
echo "Make sure you did not run this command as as super user (su, sudo)"
echo ""
echo "Did you run this command as root? (y/n)"
read superuser

if [ "$superuser" == "n" ];
then
  echo "Continuing with Git Setup"
else
  echo "Ending Setup. Run command as a normal user."
  exit 1
fi

echo "What is your email for git?"
read email1
echo "Please retype your email for git."
read email2

if [ $email1 == $email2 ];
then
  echo "Emails Match. Generating a git ID"
else
  echo "Emails do not match. Restarting git credential creation process."
  ./scripts/GitCredential.sh
  exit 1
fi

ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C $email1

echo "Setting Up Git in ~/.bash_profile"
echo '# Add Git Profile' >> ~/.bash_profile
echo 'eval $(ssh-agent -s) &>/dev/null' >> ~/.bash_profile
echo 'ssh-add ~/.ssh/id_rsa &>/dev/null' >> ~/.bash_profile

echo "To use your git credentials, you need to copy your public key(s)"
echo "over to github in your personal section under the ssh tab."
echo "These keys can be found in ~/.ssh"
exit 1
