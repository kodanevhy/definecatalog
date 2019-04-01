version: '2'
services:
  nginx:
    image: nginx:latest
{{- if ne .Values.db_link ""}}
    external_links:
      - ${db_link}:db
{{- else}}
    links:
      - db:db
  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${mysql_password}
      MYSQL_USER: ${mysql_user}
      MYSQL_PASSWORD: ${mysql_password}
      MYSQL_DATABASE: ${mysql_db}
    volumes:
      - /var/lib/catalog/nginx/nginx-db:/var/lib/mysql
{{- end}}
  lb:
    image: rancher/lb-service-haproxy:v0.7.9
    ports:
    - ${http_port}:${http_port}/tcp
    - ${ssh_port}:${ssh_port}/tcp
