# Drupal Postgres Docker Setup

<h1>Manual</h1>

1) Clone the project
2) CD in the project directory
3) Run `docker-compose up` or `docker-compose up -d` if you want to run it in the background
4) Visit https://localhost:8080
5) Follow the setup prompt for drupal. 
6) User `postgres` for database and username. Use `example` for password.
7) Drupal will look for localhost as the default database location that's why you need to click on `Advanced Settings` and change `localhost` to postgres.


<h2>Cleanup</h2>

Run `docker-compose down -v` (The -v flag makes sure to remove all the volumes created during the setup)
