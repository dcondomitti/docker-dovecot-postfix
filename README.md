This is the source to build a Docker image that will let you run temporary IMAP
and SMTP servers sandboxed on your local machine, in a way compatible with
Geary.

Build the Docker image:

    sudo docker build -t test .

Run the image:

    container=`sudo docker run -d test`

Find the IP address of the running image:

    sudo docker inspect $container | grep IPAddress | cut -d: -f2- | tr -d ' ",'

The image's root password is root, and there's also a normal user named test,
password test.  You can ssh in if you need to examine things.

Now you can configure Geary.  Add a new "Other" account with the email address
<test@example.com>.  Use the image's IP address as both the IMAP and SMTP
server.  Use test/test as the user/pass for both.  Set Encryption to None for
both as well.

The SMTP server will accept mail to <test@example.com>.

When you're done testing, stop the running image:

    sudo docker stop $container
