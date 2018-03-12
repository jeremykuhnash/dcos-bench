FROM tiangolo/uwsgi-nginx-flask:flask
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
COPY ./app /app
COPY ./etc/nginx/conf.d/nginx.conf /etc/nginx/conf.d/nginx.conf
EXPOSE 8000
EXPOSE 9000
