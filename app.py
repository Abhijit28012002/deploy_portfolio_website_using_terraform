from flask import Flask,render_template,send_from_directory

app=Flask(__name__)


@app.route("/")
def home():
    return render_template("index.html")


@app.route('/get-files/<path:path>',methods = ['GET','POST'])
def get_files_images(path):

    """Download a file."""
    try:
        return send_from_directory("./static/", path, as_attachment=True)
    except FileNotFoundError:
        return render_template('404.html'),404




# Create Custom Error Page
# Invalid URL
@app.errorhandler(404)
def page_not_found(e):
    return render_template("404.html"), 404


# Internal Server Error
@app.errorhandler(500)
def page_not_found(e):
    return render_template("500.html"), 500

# Run the code 
if __name__ == "__main__":
    app.run(host='0.0.0.0',debug=True)
