#Base Image
FROM python:3.10

ENV PYTHONUNBUFFERED=1

#Install Package
RUN apt update && apt install -y \
    build-essential \
    binutils \
    libproj-dev \
    net-tools \
    nano

# Create Folder
RUN mkdir -p /app

#Set Workdir & Copy App
WORKDIR /app
COPY . .

#Install Python Package with requirements file
RUN pip install --no-cache-dir -r requirements.txt
RUN chmod -R +x ./deploy
# migrate migration files
# RUN ./manage.py migrate

#Expose Port
# api
EXPOSE 8000

# RUN location=$(pip show enterprise | grep -oP '(?<=Location: ).*') && cp -r migrator/enterprise/* "$location/enterprise/structures/"
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate

# RUN mkdir -p static
# RUN echo yes | python3 manage.py collectstatic
CMD ["python3","manage.py","runserver","0.0.0.0:8000"]
