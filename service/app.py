from flask import Flask, render_template, request, send_from_directory
import werkzeug
import os
app = Flask(__name__, static_url_path='')
	
@app.route('/uploader', methods = ['POST'])
def upload_file():
   if request.method == 'POST':
      f = request.files['file']
      f.save(werkzeug.utils.secure_filename(f.filename))
      return 'file uploaded successfully'

@app.route('/get', methods = ['GET'])
def get_file():

   if request.method == 'GET':
       root_dir = os.path.dirname(os.getcwd())
       print(root_dir)
       filename = request.args.get('file')
       print(filename)
       return send_from_directory(root_dir, filename)

		
if __name__ == '__main__':
   app.run("0.0.0.0", debug=True)