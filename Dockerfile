FROM python:3-alpine3.15

# Set the working directory
WORKDIR /app/backend

# Copy requirements.txt into the container
COPY requirements.txt /app/backend

# Install necessary system dependencies for Alpine
RUN apk update && \
    apk add --no-cache gcc musl-dev libffi-dev python3-dev \
    mariadb-connector-c-dev pkgconfig

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . /app/backend

# Expose the port that the app will run on
EXPOSE 8000

# Set the default command to run the application
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
