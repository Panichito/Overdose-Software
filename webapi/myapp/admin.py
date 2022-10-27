from django.contrib import admin
from .models import *
from django.apps import apps

app=apps.get_app_config('myapp')
for model_name, model in app.models.items():
    admin.site.register(model)

admin.site.site_header='CPE327 - Patient Tracker Application'