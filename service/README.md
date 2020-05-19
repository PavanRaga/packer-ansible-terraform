This service is to upload and retrive the files from the server.

#To upload:
curl -i -X POST -H "Content-Type: multipart/form-data" -F "file=@filepath" http://serverip:5000/uploader

#To retrive
curl "http://serverip:5000/get?file=filename"