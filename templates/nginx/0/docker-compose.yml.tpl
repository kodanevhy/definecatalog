version: '2'
services:
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${mysql_password}
      MYSQL_USER: ${mysql_user}
      MYSQL_PASSWORD: ${mysql_password}
      MYSQL_DATABASE: ${mysql_db}
    volumes:
      - nginx-db:/var/lib/mysql
    restart: always
  nginx:
    image: nginx:latest
{{- if ne .Values.db_link ""}}
    external_links:
      - ${db_link}:db
{{- else}}
    links:
      - db:db
    ports:
      - "9999:80"
    restart: always
{{- end}}
