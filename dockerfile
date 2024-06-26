# Use the base Ubuntu image
   FROM ubuntu:latest

   # Update and install necessary packages
   RUN apt-get update && \
       apt-get install -y \
           curl \
           unzip \
           wine \
           winetricks \
           net-tools \
           && \
       apt-get clean && \
       rm -rf /var/lib/apt/lists/*

   # Set the working directory
   WORKDIR /app

   # Download a file using curl
   RUN curl -LO https://lackeyccg.com/LackeyCCGWin.zip

   # Unzip the downloaded file
   RUN unzip LackeyCCGWin.zip -d /app/

   # Set permissions on the unzipped folders (replace folder-name with your actual folder name)
   RUN chmod -R 755 /app/LackeyCCG

   #Run winetricks
   #RUN winetricks vcrun2008
