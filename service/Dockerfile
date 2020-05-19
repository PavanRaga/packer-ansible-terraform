FROM python:3.7
MAINTAINER pavan.raga98@gmail.com
RUN useradd -ms /bin/bash pythonapp
WORKDIR /app
COPY app.py .
COPY requirements.txt .
RUN pip3 install -r requirements.txt && chown -R pythonapp:root /app
USER pythonapp
CMD ["python3", "app.py"]



