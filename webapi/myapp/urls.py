from django.urls import path
from .views import *

urlpatterns = [
    path('', Home),
    path('api/newuser', register_newuser),
]
